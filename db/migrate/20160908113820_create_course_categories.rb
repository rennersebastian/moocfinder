class CreateCourseCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :course_categories, id: :uuid do |t|
		t.references :course, type: :uuid
		t.references :category, type: :uuid
    end
  end
end
