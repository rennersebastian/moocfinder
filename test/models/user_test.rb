require 'test_helper'

class UserTest < ActiveSupport::TestCase
	setup do
		@testuser = User.new(username: 'user', email: 'user@user.de', encrypted_password: 'userpw')
	end
	
	test "should not save user without username" do
		user = User.new
		assert_not user.save
	end
	
	test "should edit user" do
		@testuser.username = "ChangedName"
		assert_equal("ChangedName", @testuser.username)
	end
	
	test "should destroy user" do
		@testuser.destroy
		assert @testuser.destroyed?
	end

end
