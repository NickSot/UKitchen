class ShoppingListsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:add_item]  

	def index
		@family = Family.find(params[:family_id])
		puts()
		@list = Family.find(params[:family_id]).shopping_lists.find(params[:id])
	end

	def new
	end

	def create
		family = Family.find(params[:family_id])

		family.shopping_lists << ShoppingList.new(sl_params)
	
		redirect_to '/families/show/' + String(family.id)
	end

	def delete

	end

	def buy_item
		
	end

	def edit
		@family = Family.find(params[:family_id])

		@list = @family.shopping_lists.find(params[:id])

		@items_enum = ItemsEnum.all
	end

	def add_item
		@family = Family.find(params[:family_id])

		puts "List id: " + String(params[:family_id])

		@list = Family.find(params[:family_id]).shopping_lists.find(params[:sl_id])
		quantity = params[:quantity]
		
		if !quantity
			quantity = 1;
		end
		quantity_unit = params[:quantity_unit]
		
		puts("STATS: \n")
		puts(quantity + " " + quantity_unit)
		itemToBeCreated = ItemsEnum.find(params[:item_id])
		puts(itemToBeCreated.name)
		item = Item.new(items_enum: itemToBeCreated, shopping_list: @list, family: @family, price: nil, quantity: quantity, quantity_unit: quantity_unit)

		item.save

		redirect_to "/families/" + String(@family.id) + "/shopping_lists/" + String(@list.id)
	end

	def sl_params
		return params.require(:shopping_list).permit(:name)
	end
end
