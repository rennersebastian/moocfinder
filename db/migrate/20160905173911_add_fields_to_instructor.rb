class AddFieldsToInstructor < ActiveRecord::Migration[5.0]
  def change
	add_column :instructors, :firstName, :string
	add_column :instructors, :i_id, :integer
	add_column :instructors, :middleName, :string
	add_column :instructors, :lastName, :string
	add_column :instructors, :fullName, :string
	add_column :instructors, :title, :string
	add_column :instructors, :bio, :string
	add_column :instructors, :department, :string
	add_column :instructors, :website, :string
	add_column :instructors, :websiteTwitter, :string
	add_column :instructors, :websiteFacebook, :string
	add_column :instructors, :websiteLinkedin, :string
	add_column :instructors, :websiteGplus, :string
  end
end