class AddNumberOfServingToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :number_of_serving, :interger
  end
end
