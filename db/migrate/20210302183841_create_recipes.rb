class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :ingredients
      t.string :steps
      t.string :level
      t.string :cooking_time
      t.integer :author_id
      t.integer :save_id
      t.integer :save_times
    end
  end
end
