class ShoppingListsController < ApplicationController
	def index
		@list = Family.find(params[:family_id]).shopping_lists[params[:id]]

		render 'index'
	end

	def new
		render 'new'
	end

	def create

	end

	def delete

	end

	def edit

	end

	def update

	end

	def sl_params
		return params.require(:shopping_list).permit(:name)
	end
end
