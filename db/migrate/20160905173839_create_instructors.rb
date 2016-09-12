class CreateInstructors < ActiveRecord::Migration[5.0]
  def change
    create_table :instructors, id: :uuid do |t|
    end
  end
end
