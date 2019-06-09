class RecipesController < ApplicationController
    def index
        @message = 'This is the page where recipes are going to be displayed'

        render 'index'
    end

    def show
        id = params[:id]

        @recipe = Recipe.find id

        @details = ItemsRecipe.where(recipe_id: id)

        render 'show'
    end

end
