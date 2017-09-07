class AddRecipeCategoryToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_reference :recipes, :recipe_category, foreign_key: true
  end
end
