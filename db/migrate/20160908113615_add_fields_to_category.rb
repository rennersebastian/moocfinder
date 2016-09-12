class AddFieldsToCategory < ActiveRecord::Migration[5.0]
  def change
	add_column :categories, :name, :string
	add_column :categories, :subCategories, :string, array: true, default: []
  end
end
