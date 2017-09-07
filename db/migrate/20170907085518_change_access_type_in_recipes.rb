class ChangeAccessTypeInRecipes < ActiveRecord::Migration[5.1]
  def change
    change_column :recipes, :access, :integer, default: 0, index: true
  end
end
