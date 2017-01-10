class AccessController < ApplicationController

  layout false

  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]

  def index
    # display text & links
  end

  def login
    # login form
  end

  def attempt_login
    if params[:username].present? && params[:password].present?

      found_user = Admin.where(:email => params[:username]).first 
      found_doctor = Doctor.where(:email => params[:username]).first 
      found_nurse = Nurse.where(:email => params[:username]).first 
      session[:temp] = params[:username]

      if found_user
  		  authorized_user = found_user.authenticate(params[:password])
        #session[:temp] = found_user.email
          #flash[:notices] = "User found." + authorized_user.password_digest.to_s #+ found_user.username.to_s
        elsif found_doctor
          #session[:temp] = found_doctor.email
  		    authorized_doctor = found_doctor.authenticate(params[:password])
        elsif found_nurse
          #session[:temp] = found_nurse.email
          authorized_nurse = found_nurse.authenticate(params[:password])
        else
          #session[:temp] = nil
	  end
   	end

    if authorized_user 
      #mark user as logged in
      session[:id] = authorized_user.id
      #session[:username] = authorized_user.email
      session[:name] = authorized_user.name
      session[:role] = "Admin"
      flash[:logged_in] = "You are now signed in " + session[:name] + " !"
      redirect_to(:controller => 'department', :action => 'index')
    
    elsif authorized_doctor
    	#mark doctor as logged in
      session[:id] = authorized_doctor.id
      #session[:username] = authorized_doctor.email
      session[:name] = authorized_doctor.name
      session[:role] = "Doctor"
      flash[:logged_in] = "You are now signed in " + session[:name] + " !"
      redirect_to(:controller => 'appointment', :action => 'index')

    elsif authorized_nurse
      #mark nurse as logged in
      session[:id] = authorized_nurse.id
      #session[:username] = authorized_nurse.email
      session[:name] = authorized_nurse.name
      session[:role] = "Nurse"
      flash[:logged_in] = "You are now signed in " + session[:name] + " !"
      redirect_to(:controller => 'appointment', :action => 'index')
      
    else
      flash[:notice] = "Invalid username/password combination." #+ authorized_user.to_s
      render('login')
    end
  end

  def logout
    #mark user as logged out
    session[:id] = nil
    session[:role] = nil
    session[:name] = nil
    #reset_session
    flash[:notice] = "You are signed out"
    render("login")
  end

  
end
