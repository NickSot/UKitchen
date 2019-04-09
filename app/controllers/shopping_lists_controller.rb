class ShoppingListsController < ApplicationController
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

	def edit
		@family = Family.find(params[:family_id])

		@list = @family.shopping_lists.find(params[:id])

		@items_enum = ItemsEnum.all
	end

	def add_item
		@family = Family.find(params[:family_id])

		puts "List id: " + String(params[:family_id])

		@list = Family.find(params[:family_id]).shopping_lists.find(params[:sl_id])

		item = ItemsEnum.find(params[:item_id])

		if @list.items.include? Item.all.where(name: item.name, price: item.price)
			redirect_to "/families/" + String(@family.id) + "/shopping_lists/" + String(@list.id)
			return
		end

		@list.items << Item.find_or_create_by(name:item.name, price: item.price)

		redirect_to "/families/" + String(@family.id) + "/shopping_lists/" + String(@list.id)
	end

	def sl_params
		return params.require(:shopping_list).permit(:name)
	end
end
