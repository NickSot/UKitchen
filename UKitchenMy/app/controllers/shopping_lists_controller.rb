class ShoppingListsController < ApplicationController
	def index
		@list = Family.find(params[:family_id]).shopping_lists[Integer(params[:id]) - 1]

		render 'index'
	end

	def new
		render 'new'
	end

	def create
		family = Family.find(params[:family_id])

		family.shopping_lists << ShoppingList.create(sl_params)

		redirect_to '/families/show/' + String(family.id)
	end

	def delete

	end

	def edit
		render 'edit'
	end

	def update

	end

	def sl_params
		return params.require(:shopping_list).permit(:name)
	end
end
