class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username] 

    if(user && user.authenticate(params[:password]))
      session[:user_id] = user.id
      redirect_to root_path, notice: "Successfully logged in!"
    else
      flash.now[:error] = "Wrong username or password!"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Successfully logged out!"
  end
end
