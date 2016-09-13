class IndexController < ApplicationController
	def index
		@course = Course.second
		@platform = Platform.first
		@category = Category.first
		@instructor = Instructor.first
	end
end