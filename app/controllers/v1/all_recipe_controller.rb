module V1
  class AllRecipeController < ApplicationController
    skip_before_action :authorize_request
    before_action :set_recipe, only: %i[show]

    # GET /recipes
    def index
      @recipes = Recipe.all
      json_response(@recipes)
    end

    # GET /recipes/:id
    def show
      json_response(@recipe)
    end

    private

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
  end
end
