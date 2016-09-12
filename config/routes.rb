Rails.application.routes.draw do
	authenticate :user do
	  resources :reviews, only: [:new, :create, :edit, :update, :destroy]
	end
	resources :reviews, only: [:index, :show]
	
	devise_for :users
	resources :courses

	root 'index#index'
	authenticate :user do
		get 'dashboard', to: 'dashboard#index', :as => "dashboard"
		get 'load', to: 'scraper#index' 
	end
	
	get 'load', to: 'scraper#index' 
	
	get 'courses', to: 'courses#index'

	get 'platforms', to: 'platforms#index', :as => "platforms"
	get 'platforms/:id', to: 'platforms#show', :as => "platform"

	get 'instructors', to: 'instructors#index', :as => "instructors"
	get 'instructors/:id', to: 'instructors#show', :as => "instructor"
	
	get 'categories', to: 'categories#index', :as => "categories"
	get 'categories/:id', to: 'categories#show', :as => "category"
	
	get 'about', to: 'static#about', :as => "about"	
	get 'contact', to: 'static#contact', :as => "contact"
	get 'moocs', to: 'static#moocs', :as => "moocs"
end