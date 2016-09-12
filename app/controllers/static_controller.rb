class StaticController < ApplicationController
	def about
		render :about
	end
	
	def contact
		render :contact
	end
	
	def moocs
		render :moocs
	end
end