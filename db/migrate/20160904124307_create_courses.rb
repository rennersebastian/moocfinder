class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses, id: :uuid do |t|
		t.references :platform, type: :uuid
    end
  end
end
