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
    @family = Family.find params[:id]
  end

  def update
    family = Family.find params[:id]

    family.update_attributes family_params

    redirect_to '/families/edit/' + String(family.id)
  end

  def show
  	@family = Family.find params[:id]

  	@members = @family.users

  	render 'show'
  end

  def add_member
    @user_to_add = User.find params[:user_id]

    user = User.find session[:user_id]

    @families = user.families
  end

  def do_add_member
    user = User.find params[:user_id]

    family = Family.find params[:family_id]

    family.users << user

    redirect_to '/', notice: 'Successfully added a user to your family!'
  end

  def family_params
  	return params.require(:family).permit(:name)
  end
end
