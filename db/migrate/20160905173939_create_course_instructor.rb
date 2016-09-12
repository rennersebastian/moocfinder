class CreateCourseInstructor < ActiveRecord::Migration[5.0]
  def change
    create_table :course_instructors, id: :uuid do |t|
		t.references :course, type: :uuid
		t.references :instructor, type: :uuid
    end
  end
end
