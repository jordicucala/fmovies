class CreateMovies < ActiveRecord::Migration[5.1]
  def up
    create_table :movies do |t|
      t.string :title
      t.text :overview
      t.integer :movie_id
      t.boolean :adult
      t.integer :vote_count
      t.float :popularity
      t.text :poster_path
      t.text :backdrop_path
      t.string :original_language
      t.string :original_title
      t.timestamp :release_date
      t.timestamps
    end
  end

  def down
    drop_table :movies
  end
end
