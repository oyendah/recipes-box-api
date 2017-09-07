class RecipeCategory < ApplicationRecord
  has_many :recipes
  validates_presence_of :name
end
