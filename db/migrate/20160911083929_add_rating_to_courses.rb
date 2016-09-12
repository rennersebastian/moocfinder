class AddRatingToCourses < ActiveRecord::Migration[5.0]
  def change
	add_column :courses, :rating, :float, default: 0
  end
end
