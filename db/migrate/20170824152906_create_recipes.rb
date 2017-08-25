class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :description
      t.string :ingredent
      t.string :time_to_cook
      t.string :instruction
      t.string :access
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
