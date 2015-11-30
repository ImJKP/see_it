class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :themoviedb_id
      t.string :original_language
      t.text :overview
      t.date :release_date
      t.string :poster_path
      t.timestamps null: false
    end
  end
end
