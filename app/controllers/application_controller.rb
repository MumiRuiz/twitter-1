class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def redirect_unless_authenticated
    redirect_to(sessions_new_path) unless authenticated?
  end

  def authenticated?
    #!current_user.nil?
    #=> return true if current_user is set, false otherwise
    !!current_user
  end

  def current_user
    @_current_user ||= User.find(session[:user_id]) rescue nil
  end
end
