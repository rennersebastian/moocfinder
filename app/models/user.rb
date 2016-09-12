class User < ApplicationRecord
	validates :username, presence: true
    validate :validate_username
	
	devise :database_authenticatable, :registerable,
		 :recoverable, :rememberable, :trackable, :validatable
		 
	has_many :reviews
	
	attr_accessor :login
	
	def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
    end
	
	def validate_username
	  if User.where(email: username).exists?
		errors.add(:username, :invalid)
	  end
	end
end
