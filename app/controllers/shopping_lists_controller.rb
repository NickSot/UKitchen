class ShoppingListsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:add_item]  

	def index
		@family = Family.find(params[:family_id])
		puts()
		@list = Family.find(params[:family_id]).shopping_lists.find(params[:id])
		@items = @list.items.where(bought:false)
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

	def delete_item
		family = Family.find(params[:family_id])
		list = family.shopping_lists.find(params[:sl_id])
		item = list.items.find(params[:item_id])

		if(family && item && list) 
			list.items -= [item]
			list.save
			redirect_to shopping_list_path(family.id, list.id), notice: "Successfully deleted item " + item.items_enum.name
		else
			redirect_to shopping_list_path(family.id, list.id), notice: "No such family, item or shopping list to delete"
		end
	end

	def buy_item
		family = Family.find(params[:family_id])
		list = family.shopping_lists.find(params[:sl_id])
		item = list.items.find(params[:item_id])
		item.bought = true
		item.save
		redirect_to shopping_list_path(family.id, list.id), notice: "Successfully added item " + item.items_enum.name + " to " + family.name + "'s current stock"
		
	end

	def edit
		@family = Family.find(params[:family_id])
		@list = @family.shopping_lists.find(params[:id])
		@items_enum = ItemsEnum.all
	end

	def add_item
		@family = Family.find(params[:family_id])
		@list = Family.find(params[:family_id]).shopping_lists.find(params[:sl_id])
		quantity = params[:quantity]
		quantity_unit = params[:quantity_unit]
		itemToBeCreated = ItemsEnum.find(params[:item_id])		
		
		if !quantity
			quantity = 1;
		end

		if @list.items
			.map{|item| [item.items_enum, item.quantity_unit]}
			.include?([itemToBeCreated, quantity_unit])
			item = Item.find_by items_enum: itemToBeCreated, quantity_unit: quantity_unit
			item.quantity += quantity.to_i
			item.save
		else
			item = Item.new(items_enum: itemToBeCreated, shopping_list: @list, family: @family, price: nil, quantity: quantity, quantity_unit: quantity_unit)

			item.save
		end

		redirect_to "/families/" + String(@family.id) + "/shopping_lists/" + String(@list.id)
	end

	def sl_params
		return params.require(:shopping_list).permit(:name)
	end
end
