class ScraperController < ApplicationController
	before_action :ensure_admin
	
	def index
		CourseraScraper.initialize
		UdacityScraper.initialize
		redirect_to '/'
	end
	
	private
	
	def ensure_admin
	  unless current_user.admin?
		redirect_to('/', notice: 'Not authorized')
	  end
	end
end