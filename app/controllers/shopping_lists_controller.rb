class ShoppingListsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:add_item, :buy_item]  

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
		item_name = item.items_enum.name
		
		quantity = params[:quantity].to_i
		existingItem = Item.find_by items_enum: item.items_enum, quantity_unit: item.quantity_unit, bought: true
		
		if !quantity
			quantity = item.quantity
		end
		if not existingItem
			if quantity < item.quantity
				newItemQuantity = item.quantity - quantity
				item.quantity = quantity

				newItem = Item.new(items_enum: item.items_enum, shopping_list: list, family: family, price: params[:price].to_i, quantity: newItemQuantity, quantity_unit: item.quantity_unit)
				newItem.save				
			end

			item.bought = true
			item.save

			puts item

			transaction = Transaction.new

			transaction.category_name = item.items_enum.category_name
			transaction.price = params[:price].to_f * params[:quantity].to_i
			transaction.price_unit = params[:price_unit]
			transaction.family_id = family.id
			
			transaction.save

			puts 'HERE'

			puts transaction

			puts family

			family.budget -= transaction.price

			family.save

		else
			existingItem.quantity += item.quantity
			existingItem.save
			item.destroy
		end

		redirect_to shopping_list_path(family.id, list.id), notice: "Successfully added item " + item_name + " to " + family.name + "'s current stock"
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
			.map{|item| [item.items_enum, item.quantity_unit, item.bought]}
			.include?([itemToBeCreated, quantity_unit, false])
			item = Item.find_by items_enum: itemToBeCreated, quantity_unit: quantity_unit
			item.quantity += quantity.to_i
		else
			item = Item.new(items_enum: itemToBeCreated, shopping_list: @list, family: @family, price: nil, quantity: quantity, quantity_unit: quantity_unit)
		end
		item.save

		redirect_to "/families/" + String(@family.id) + "/shopping_lists/" + String(@list.id)
	end

	def sl_params
		return params.require(:shopping_list).permit(:name)
	end
end
