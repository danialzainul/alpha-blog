class SessionsController < ApplicationController
  # Renders the view file to login
  def new
    
  end
  # POST action to submit login form
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new'
    end
  end
  # Logout the user
  def destroy
    session[:user_id] = nil
    flash[:success] = "Thank you for using Alpha-Blog"
    redirect_to root_path
  end
  
end