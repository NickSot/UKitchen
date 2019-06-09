class RecipesController < ApplicationController
    def index
        @message = 'This is the page where recipes are going to be displayed'

        render 'index'
    end

    def show

    end

end
