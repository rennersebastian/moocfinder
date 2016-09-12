class AddFieldsToPlatform < ActiveRecord::Migration[5.0]
  def change
	add_column :platforms, :name, :string, null: false
	add_column :platforms, :description, :string
	add_column :platforms, :address, :string, null: false
	add_column :platforms, :logoRef, :string
  end
end
