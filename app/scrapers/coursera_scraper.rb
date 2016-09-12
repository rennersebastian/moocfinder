class CourseraScraper
	include HTTParty
	@@COURSES = Array.new
	@@INSTRUCTORS = Array.new
	#@@URL = 'https://api.coursera.org/api/courses.v1?start='
	@@URL = 'https://api.coursera.org/api/courses.v1?start='
	@@FIELDS = '&limit=10&fields=description,primaryLanguages,startDate,domainTypes,instructorIds'
	@@COURSEURL = 'https://www.coursera.org/learn/'
	@@COURSERA_URL = 'https://www.coursera.org/'
	@@PLATFORM
	@@INSTRUCTOR_URL = 'https://api.coursera.org/api/instructors.v1?start='
	@@INSTRUCTOR_FIELDS = '&fields=bio,firstName,middleName,lastName,title,department,website,websiteTwitter,websiteFacebook,websiteLinkedin,websiteGplus'
	
	def self.initialize		
		createPlatform
		
		instructorApiCall
		createInstructorHash
		
		courseApiCall
		createCourseHash
	end
	
	private
	
	# Create platform reference	
	def self.createPlatform
		platformHash = { 
				"name" => "Coursera", 
				"description" => "Coursera provides universal access to the world's best education, partnering with top universities and organizations to offer courses online.", 
				"address" => @@COURSERA_URL, 
				"logoRef" =>  "coursera.jpg"
		}		
		@@PLATFORM = Platform.create(platformHash)
	end
	
	# Get instructor infos in JSON format from coursera
	def self.instructorApiCall
		n = 0
		total = 5

		while n < total  do
			response = HTTParty.get(@@INSTRUCTOR_URL + n.to_s + @@INSTRUCTOR_FIELDS)					
			json_response = JSON.parse(response.body)
			
			instructorDetails = json_response['elements']
			@@INSTRUCTORS.concat(instructorDetails)
			
			n = json_response['paging']['next'].to_i
			total = json_response['paging']['total'].to_i
			
			break if n == 0
		end
	end
	
	# Remove unused attributes and rename keys to fit database
	def self.createInstructorHash
		@@INSTRUCTORS.each do |instructor|		
			if instructor['firstName'] != nil ||instructor['lastName'] != nil
				instructorHash = { 
					"fullName" => instructor['fullName'], 
					"i_id" => instructor['id'], 
					"bio" => instructor['bio'], 
					"firstName" => instructor['firstName'], 
					"middleName" => instructor['middleName'], 
					"lastName" => instructor['lastName'], 
					"title" => instructor['title'], 
					"department" => instructor['department'], 
					"website" => instructor['website'], 
					"websiteTwitter" => instructor['websiteTwitter'], 
					"websiteFacebook" => instructor['websiteFacebook'], 
					"websiteLinkedin" => instructor['websiteLinkedin'], 
					"websiteGplus" => instructor['websiteGplus']
				}
				Instructor.create(instructorHash)
			end
		end
	end
	
	# Get course infos in JSON format from coursera
	def self.courseApiCall
		n = 0
		total = 5

		while n < total  do
			response = HTTParty.get(@@URL + n.to_s + @@FIELDS)					
			json_response = JSON.parse(response.body)
			
			courseDetails = json_response['elements']
			@@COURSES.concat(courseDetails)
			
			n = json_response['paging']['next'].to_i
			total = json_response['paging']['total'].to_i
			
			break if n == 0
		end
	end
	
	# Remove unused attributes and rename keys to fit database
	def self.createCourseHash
		@@COURSES.each do |course|			
			catIds = Array.new
			course['domainTypes'].each do |domain|
				string = domain['domainId'].gsub(/[-]/, ' ')
				if(Category.exists?(name: string))
					catIds.push(Category.find_by(name: string).id)
				else
					categoryHash = {
						"name" => string
					}
					newCat = Category.create(categoryHash)
					catIds.push(newCat.id)
				end
			end
			
			ids = course['instructorIds']
			
			courseHash = { 
				"name" => course['name'], 
				"description" => course['description'], 
				"startDate" => course['startDate'], 
				"languages" => course['primaryLanguages'], 
				"courseURL" =>  @@COURSEURL+course['slug'],
				"platform_id" => @@PLATFORM['id']
			}
			
			createCourse(courseHash, ids, catIds)
		end
	end
	
	# Create Course object and Course-Instructor Association
	def self.createCourse(course, ids, catIds)
		createdCourse = Course.create(course)
		ids.each do |id|
			string = "i_id = " + id
			
			idHash = { 
				"course_id" => createdCourse['id'],
				"instructor_id" => Instructor.where(string).take['id']
			}
			
			CourseInstructor.create(idHash)
		end
		catIds.each do |id|
			string = "i_id = " + id
			
			idHash = { 
				"course_id" => createdCourse['id'],
				"category_id" => id
			}
			
			CourseCategory.create(idHash)
		end
	end
end

