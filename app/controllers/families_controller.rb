class FamiliesController < ApplicationController
  def new
    @family = Family.new

    if session[:user_id] == nil
      redirect_to '/', notice: 'You have not logged in!'
    end
  end

  def create
  	@family = Family.create family_params

    user = User.find session[:user_id]

    user.families << @family

    redirect_to '/', notice: 'family successfully created!'
  end

  def edit

  end

  def show
  	@family = Family.find params[:id]

  	@members = @family.users

  	render 'show'
  end

  def family_params
  	return params.require(:family).permit(:name)
  end
end
