class Course < ApplicationRecord
	has_many :instructors, through: :course_instructors
    has_many :course_instructors	
	has_many :categories, through: :course_categories
    has_many :course_categories
	has_many :reviews, dependent: :destroy
	belongs_to :platform
	
	include PgSearch
	pg_search_scope :search_keyword, :against => {
		:name => 'A',
		:description => 'B'
	}, :using =>  {
		:tsearch => {:any_word => true}
	}
end
