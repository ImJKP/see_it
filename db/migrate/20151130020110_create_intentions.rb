class CreateIntentions < ActiveRecord::Migration
  def change
    create_table :intentions do |t|
      t.integer :user_id
      t.integer :movie_id

      t.timestamps null: false
    end
  end
end
