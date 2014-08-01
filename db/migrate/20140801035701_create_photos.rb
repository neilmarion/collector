class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :text
      t.string :photo

      t.timestamps
    end
  end
end
