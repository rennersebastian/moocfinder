class CreatePlatforms < ActiveRecord::Migration[5.0]
  def change
    create_table :platforms, id: :uuid do |t|
    end
  end
end
