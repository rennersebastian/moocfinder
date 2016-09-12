class Category < ApplicationRecord
	has_many :courses, through: :course_categories
    has_many :course_categories
end
