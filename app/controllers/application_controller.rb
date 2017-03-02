class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # To enable the below methods to be used in view files
  helper_method :current_user, :logged_in?
  
  def current_user
    # || will only set @current_user IF @current_user is not set already
    # this prevents us from querying the database everytime we use current_user,
    # as we only find the current_user once then assign it to @current_user
    # refer to http://railscasts.com/episodes/1-caching-with-instance-variables
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    # to check if @current_user exists. Return True if yes
    # !! is used to get a boolean answer (true / false)
    !!current_user
  end
  
  def require_user
    # if NOT logged in
    if !logged_in?
      flash[:danger] = "You must be logged in to perform this action"
      redirect_to root_path
    end
  end
end
