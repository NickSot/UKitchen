class FamiliesController < ApplicationController
  before_action :require_login
 
  def index
    user  = User.find session[:user_id]
    @families = user.families
  end

  def new
    @family = Family.new

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

  def add_members
    @users = User.all
    # @user_to_add = User.find params[:user_id]
    @family = Family.find params[:family_id]

  end

  def do_add_member
    user = User.find params[:user_id]

    family = Family.find params[:family_id]

    family.users << user

    redirect_to '/families/show/'+ String(family.id), notice: 'Successfully added a user to your family!'
  end

  def kick
    user = User.find params[:user_id]
    family = Family.find params[:family_id]

    family.users.delete(user)
    redirect_to '/families/show/' + String(family.id), notice: 'Successfully kicked' + user.username + 'from your family!'
    
    end

  private
 
  def require_login
    unless session[:user_id] != nil
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path # halts request cycle
    end
  end

  def family_params
  	return params.require(:family).permit(:name)
  end
end
