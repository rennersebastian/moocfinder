class AddFieldsToCourse < ActiveRecord::Migration[5.0]
  def change
	add_column :courses, :name, :string
	add_column :courses, :description, :string
	add_column :courses, :courseURL, :string
	add_column :courses, :startDate, :timestamp
	add_column :courses, :languages, :string, array: true, default: []
  end
end
