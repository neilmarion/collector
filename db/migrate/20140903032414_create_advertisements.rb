class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.text :text
      t.string :photo
      t.string :link
      t.integer :album_id

      t.timestamps
    end
  end
end
