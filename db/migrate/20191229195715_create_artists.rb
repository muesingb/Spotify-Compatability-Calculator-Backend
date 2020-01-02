class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.integer :user_id
      t.string :image_info

      t.timestamps
    end
  end
end
