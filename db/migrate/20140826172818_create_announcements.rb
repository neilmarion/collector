class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.text :message
      t.integer :album_id

      t.timestamps
    end
  end
end
