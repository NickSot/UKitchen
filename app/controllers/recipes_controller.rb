class RecipesController < ApplicationController
    def index
        if params[:recipe_name] == nil
            @recipes = Recipe.all
        else
            @recipes = Recipe.where("name like ?", "%#{params[:recipe_name]}%")
        end
    end

    def show
        id = params[:id]
        @recipe = Recipe.find id
        @details = ItemsRecipe.where(recipe_id: id)
        # @families = User.find(session[:user_id]).families
    end

end
