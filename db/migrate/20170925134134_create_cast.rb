class CreateCast < ActiveRecord::Migration[5.1]
  def change
    create_table :casts do |t|
      t.string :name
      t.string :character
      t.integer :gender
      t.text :profile_path
      t.integer :cast_id
      t.integer :order
      t.references :movie

      t.timestamps
    end
  end

  def down
    drop_table :casts
  end
end
