class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews, id: :uuid do |t|
      t.integer :rating
      t.string :review		
		t.references :user, type: :integer
		t.references :course, type: :uuid
      t.timestamps
    end
  end
end
