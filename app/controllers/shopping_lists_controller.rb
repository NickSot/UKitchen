class ShoppingListsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:add_item, :buy_item]  
	require 'date'

	def index
		@family = Family.find(params[:family_id])
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
		item_name = item.items_enum.name
		category_name =  item.items_enum.category_name
		params_price = params[:price].to_f
		params_quantity = params[:quantity].to_i

		existingItem = Item.find_by items_enum: item.items_enum, bought: true
		if params_quantity == 0
			params_quantity = item.quantity
		end

		if not existingItem
			if params_quantity < item.quantity
				newItemQuantity = item.quantity - params_quantity
				item.quantity = params_quantity

				newItem = Item.new(items_enum: item.items_enum, shopping_list: list, family: family, price: params[:price].to_i, quantity: newItemQuantity)
				newItem.save				
			end

			item.bought = true
			item.save
		else
			if params_quantity < item.quantity
				quantityToAdd = params_quantity
				item.quantity -= params_quantity
				item.save
			else
				quantityToAdd =  item.quantity
				item.destroy
			end
			existingItem.quantity += quantityToAdd
			existingItem.save
		end
	
		transaction = Transaction.new
		transaction.category_name = category_name
		transaction.price = params_price * params_quantity
		transaction.price_unit = "levs"
		transaction.family_id = family.id
		transaction.save
		
		family.current_budget_state -= transaction.price
		family.save
		
		redirect_to shopping_list_path(family.id, list.id), notice: "Successfully added item to family's current stock"
	end

	def edit
		@family = Family.find(params[:family_id])
		@list = @family.shopping_lists.find(params[:id])
		@items_enum = ItemsEnum.all.order("category_name")
	end

	def add_item
		@family = Family.find(params[:family_id])
		@list = Family.find(params[:family_id]).shopping_lists.find(params[:sl_id])
		quantity = params[:quantity]
		itemToBeCreated = ItemsEnum.find(params[:item_id])		
		
		if !quantity
			quantity = 1;
		end

		if @list.items
			.map{|item| [item.items_enum, item.bought]}
			.include?([itemToBeCreated, false])
			item = Item.find_by items_enum: itemToBeCreated
			item.quantity += quantity.to_i
		else
			item = Item.new(items_enum: itemToBeCreated, shopping_list: @list, family: @family, price: nil, quantity: quantity)
		end
		item.save

		redirect_to "/families/" + String(@family.id) + "/shopping_lists/" + String(@list.id)
	end

private

	def sl_params
		return params.require(:shopping_list).permit(:name)
	end
end
