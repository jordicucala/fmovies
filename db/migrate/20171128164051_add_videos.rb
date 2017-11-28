class AddVideos < ActiveRecord::Migration[5.1]
  def change

    create_table :videos do |t|
      t.text :name
      t.integer :video_id
      t.string :key
      t.string :site
      t.integer :size
      t.integer :video_type
      t.references :videoable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end

  def down
    drop_table :videos
  end
end
