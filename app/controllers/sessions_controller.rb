class SessionsController < ApplicationController
  
  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome, you've logged in."
      redirect_to upload_path
    else
      flash[:error] = "There is something wrong with your username or password."
      redirect_to login_path
    end
  end

  def destroy
    User.find(session[:user_id]).destroy # delete user who logged out
    session[:user_id] = nil
    flash[:notice] = "You've logged out. Go ahead and merge more files if you want."
    redirect_to root_path

  end

end