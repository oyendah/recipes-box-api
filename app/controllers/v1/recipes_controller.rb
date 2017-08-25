module V1
  class RecipesController < ApplicationController
    before_action :set_user
    before_action :set_user_recipe, only: %i[show update destroy]

    # GET /users/:user_id/recipes
    def index
      json_response(@user.recipes)
    end

    # GET /users/:user_id/recipes/:id
    def show
      json_response(@recipe)
    end

    # PUT /users/:user_id/recipes/:id
    def update
      @recipe.update(recipe_params)
      head :no_content
    end

    # POST /users/:user_id/recipes
    def create
      @user.recipes.create!(recipe_params)
      json_response(@user.recipes, :created)
    end

    # DELETE /users/:user_id/recipes/:id
    def destroy
      @recipe.destroy
      head :no_content
    end

    private

    def recipe_params
      params.permit(
        :title,
        :description,
        :ingredient,
        :time_to_cook,
        :instruction,
        :access,
        :number_of_serving
      )
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_user_recipe
      @recipe = @user.recipes.find_by!(id: params[:id]) if @user
    end
  end
end
