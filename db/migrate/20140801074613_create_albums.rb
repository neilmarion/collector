class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :fb_id
      t.string :name

      t.timestamps
    end
  end
end
