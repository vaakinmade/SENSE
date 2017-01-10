class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 # protect_from_forgery with: :exception

  #//$("#large").html("<%= escape_javascript(render partial: 'newform' ) %>");  

private

  def confirm_logged_in
  	unless session[:id]
  		#flash[:notice] = "Please log in."
  		redirect_to(:controller => 'access',:action => "login")
  		return false #halts the before_action
  	else
  		return true
  	end
  end

end
