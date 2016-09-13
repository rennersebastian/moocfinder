class UdacityScraper
	include HTTParty
	@@COURSES = Array.new
	@@INSTRUCTORS = Array.new
	@@URL = 'https://www.udacity.com/public-api/v0/courses'
	@@UDACITY_URL = 'https://www.udacity.com'
	@@PLATFORM
	
	def self.initialize		
		createPlatform
		
		courseApiCall
		createCourseHash
	end
	
	private
	
	# Create platform reference	
	def self.createPlatform
		platformHash = { 
				"name" => "Udacity", 
				"description" => "Building an online university, that teaches the skills that industry employers need today, delivers credentials endorsed by employers and educates at a fraction of the cost of traditional schools", 
				"address" => @@UDACITY_URL, 
				"logoRef" =>  "udacity.jpg"
		}		
		@@PLATFORM = Platform.create(platformHash)
	end
	
	# Get course infos in JSON format from coursera
	def self.courseApiCall
		response = HTTParty.get(@@URL)					
		json_response = JSON.parse(response.body)
		
		courseDetails = json_response['courses']
		@@COURSES = courseDetails
	end
	
	# Remove unused attributes and rename keys to fit database
	def self.createCourseHash
		ary = ["en"]
		@@COURSES.each do |course|					
			ins = course['instructors']
			puts ins.inspect
			
			courseHash = { 
				"name" => course['title'], 
				"description" => course['summary'], 
				"languages" => ary, 
				"courseURL" =>  course['homepage'],
				"platform_id" => @@PLATFORM['id']
			}
			
			createCourse(courseHash, ins)
		end
	end
	
	# Create Course object and Course-Instructor Association
	def self.createCourse(course, ins)
		createdCourse = Course.create(course)
		ins.each do |instructor|	
			if instructor['name'].to_s != "" && !Instructor.exists?(fullName: instructor['name'])
				names = instructor['name'].split(' ')
				instructorHash = { 
					"fullName" => instructor['name'], 
					"bio" => instructor['bio'], 
					"firstName" => names[0], 
					"lastName" => names[1]
				}
				instruc = Instructor.create(instructorHash)
				
				idHash = { 
					"course_id" => createdCourse['id'],
					"instructor_id" => instruc.id
				}
				CourseInstructor.create(idHash)
			end
		end
	end
end