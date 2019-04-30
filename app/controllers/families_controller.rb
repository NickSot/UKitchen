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
  	@family = Family.new family_params

    user = User.find session[:user_id]

    admin = Administrator.create(user_id: user.id)

    @family.administrator = admin

    @family.save

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

  def edit_budget
    @family = Family.find params[:family_id]

    render 'edit_budget'
  end

  def do_edit_budget
    family = Family.find params[:family_id]

    family.update_attributes family_params

    redirect_to '/families/show/' + String(family.id)
  end

  def show
  	@family = Family.find params[:id]
    
  	@members = @family.users

  	render 'show'
  end

  def add_members
    @users = User.all
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

    if session[:user_id] == family.administrator.user_id
      family.users.delete(user)
      redirect_to '/families/show/' + String(family.id), notice: 'Successfully kicked ' + user.username + ' from your family!'
    else
      redirect_to '/families/show/' + String(family.id), notice: 'Cannot kick from a family if you are not the creator!'
    end

  end

  def search
    s = params[:q]
    # @users = User.all
    @users = User.where("username LIKE '%#{s}%'")

    @family = Family.find params[:family_id] 
    render "add_members"
  end

private
 
  def require_login
    unless session[:user_id] != nil
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path # halts request cycle
    end
  end

  def family_params
  	return params.require(:family).permit(:name, :budget)
  end
end
