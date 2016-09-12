require 'test_helper'

class PlatformTest < ActiveSupport::TestCase
	setup do
		@platform = Platform.new(name: 'SetupPlatform', address: 'setup@setup.de', description: 'setup platform for testing.')
	end

	test "should not save platform without name" do
		assert_raises("StatementInvalid") do
			platform = Platform.new
			assert_not platform.save
		end		
	end
	
	test "should save platform" do
		platform = Platform.new(name: 'TestPlatform', address: 'test@test.de', description: 'A new platform for testing.')
		assert platform.save
	end
	
	test "should edit platform" do
		@platform.name = "ChangedName"
		assert_equal("ChangedName", @platform.name)
	end
	
	test "should destroy platform" do
		@platform.destroy
		assert @platform.destroyed?
	end
end