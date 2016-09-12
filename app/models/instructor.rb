class Instructor < ApplicationRecord
	has_many :courses, through: :course_instructors
    has_many :course_instructors
end
