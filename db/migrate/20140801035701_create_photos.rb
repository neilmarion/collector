class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :text
      t.string :photo
      t.string :fb_id
      t.integer :album_id

      t.timestamps
    end
  end
end
