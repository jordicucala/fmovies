class AddMovieAttributes < ActiveRecord::Migration[5.1]
  def change
    change_table :movies do |t|
      t.boolean :adult
      t.integer :vote_count
      t.float :popularity
      t.text :poster_path
      t.text :backdrop_path
      t.string :original_language
      t.string :original_title
      t.timestamp :release_date
    end
  end
end
