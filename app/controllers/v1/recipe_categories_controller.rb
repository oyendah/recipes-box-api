module V1
  class RecipeCategoriesController < ApplicationController
    skip_before_action :authorize_request
    before_action :set_recipe_category, only: %i[show update destroy]

    def index
      @recipe_category = RecipeCategory.all
      json_response(@recipe_category)
    end

    def show
      json_response(@recipe_category)
    end

    def update
      @recipe_category.update(recipe_category_params)
      head :no_content
    end

    def create
      recipe_category = RecipeCategory.create!(recipe_category_params)
      response =
        { message: Message.record_created('Category'),
          recipe_category: recipe_category }
      json_response(response, :created)
    end

    def destroy
      @recipe_category.destroy
      head :no_content
    end

    private

    def recipe_category_params
      params.permit(
        :name
      )
    end

    def set_recipe_category
      @recipe_category = RecipeCategory.find(params[:id])
    end
  end
end
