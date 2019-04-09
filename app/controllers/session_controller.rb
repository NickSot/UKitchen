class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username] 

    if(user && user.authenticate(params[:password]))
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in!"
      redirect_to user_path(user.id)
    else
      flash[:error] = "Wrong username or password!"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out!"
    redirect_to root_path
  end
end
