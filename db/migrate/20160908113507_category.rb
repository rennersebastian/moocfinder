class Category < ActiveRecord::Migration[5.0]
  def change
    create_table :categories, id: :uuid do |t|
    end
  end
end
