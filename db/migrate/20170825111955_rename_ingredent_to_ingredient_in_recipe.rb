class RenameIngredentToIngredientInRecipe < ActiveRecord::Migration[5.1]
  def change
    rename_column :recipes, :ingredent, :ingredient
  end
end
