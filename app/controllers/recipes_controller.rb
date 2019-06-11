class RecipesController < ApplicationController
    before_action :require_login
    def index
        recipe_name = params[:recipe_name]
        ingredient_name = params[:ingredient_name]
        family_id = params[:family_id]
        @family = Family.find_by id: family_id
        @family_id = @family ? @family.id : -1

        if !ingredient_name
            @ingredients = ItemsEnum.all
        else
            @ingredients = ItemsEnum.where("name like ? OR category_name like ?", "%#{ingredient_name}%", "%#{ingredient_name}%")
        end

        if !recipe_name
            @recipes = Recipe.all
        else
                @recipes = @recipes.where("recipe.name like ?", "%#{params[:recipe_name]}%")
        end
        @families = User.find(session[:user_id]).families
    end

    def show
        id = params[:id]
        @recipe = Recipe.find id
        @details = ItemsRecipe.where(recipe_id: id)
        @families = User.find(session[:user_id]).families
    end

    def search_recipes
        checkedItems = params[:checked];
        puts("CHEEECKEEEED ITEMS"); 
        puts(checkedItems);
        if(checkedItems)
            checkedItems = checkedItems.map{|item| item.to_i}
            @recipes = Recipe.joins(:ingredients).where("items_enums.id IN (?)", checkedItems)
            respond_to do |format|
                format.json do
                    render json: @recipes.to_json
                end
            end
        else
            render json: [{}]
        end
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

    def require_login
    unless session[:user_id] != nil
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path # halts request cycle
    end
  end

end
