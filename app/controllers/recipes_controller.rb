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
        @families = User.find(session[:user_id]).families
    end

    def add
        @families = User.find(session[:user_id]).families

        @shopping_lists = []

        @families.each do |f|
            f.shopping_lists.each do |sl|
                @shopping_lists << sl
            end
        end

        render 'add'
    end

    def add_ingredient
        family = Family.find(params[:recipe][:family])

        shopping_list = ShoppingList.find(params[:recipe][:shopping_list])

        recipe = Recipe.find(params[:id])

        details = ItemsRecipe.where(recipe_id: recipe.id)

        counter = 0

        recipe.ingredients.each do |ing|
            if not family.items.map{|item| item.items_enum.name}.include?(ing.name) 
                to_add = Item.new items_enum: ing, shopping_list: shopping_list, family: family, price: nil, quantity: details[counter].quantity
                shopping_list.items << to_add
            else
                puts 'HERE'
                # if family.items.map{|item| item.items_enum.name}.include?(ing.name)
                family.items.each do |item|
                    if item.quantity < details[counter].quantity
                        diff = details[counter].quantity - item.quantity

                        # puts 'quantity: ' + diff

                        item.quantity = diff

                        item.price = nil

                        shopping_list.items << item
                    end
                end
                # end
            end

            shopping_list.save

            counter+=1
        end

        redirect_to '/recipes'
    end

end
