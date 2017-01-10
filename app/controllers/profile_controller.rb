class ProfileController < ApplicationController
  
  layout "doctor_admin"
  
  before_action :confirm_logged_in



  def index
    if session[:role] == "Nurse"
      @profile = Nurse.where(:id => session[:id]).first
      #flash[:notice] = "." + @profile.id.to_s
    elsif session[:role] == "Doctor"
      @profile = Doctor.where(session[:id]).first
    end
  end

  def password_change
    if session[:role] == "Nurse" or session[:role] == "Doctor"

      if params[:new_password].present? && params[:retype_password].present? && params[:password].present?
        
        if session[:role] == "Nurse"
          @update_profile = Nurse.find(session[:id])
          @find_password = @update_profile.authenticate(params[:password])
        elsif session[:role] == "Doctor"
          @update_profile = Doctor.find(session[:id])
          @find_password = @update_profile.authenticate(params[:password])
        end

        if @find_password

          if params[:new_password] == params[:retype_password]
            #@profile = Nurse.where(:id => session[:id]).first

            @update_profile.update_attributes(:password => params[:new_password])
            flash[:notice_password] = "Password changed"
            redirect_to(:action => 'index2')
          else
            flash[:error_password] = "Error. New passwords don't match"
            redirect_to(:action => 'index2')
          end
        else
            flash[:error_password] = "Error. Invalid Current Password"
            redirect_to(:action => 'index2')
        end    
      else
            flash[:error_password] = "Error. Ensure all fields are filled" + params[:password]
            redirect_to(:action => 'index2')
      end
    end
  end

  def edit
    @profile = Nurse.find(params[:id])
    @profile_count = Nurse.count
  end

  def update
     # Find an existing object using form parameters  
     @profile = Nurse.find(params[:id])
     # Update the object
    if  @profile.update_attributes(profile_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "profile saved"
      redirect_to(:action => 'index')
    else
      @profile_count = Nurse.count
    # If update fails, redisplay the form so user can fix problems
    render('edit')
    end
  end

  
  private 

  def profile_params
        # - same as using "params[:profile]", except that it:
        # - raises an error if :profile is not present
        # - allows listed attributes to be mass assigned

        params.require(:profile).permit(:name, :email, :password, :new_password, :department_id, :address, :phone, :gender, :postcode, :specialty, :created_at)
  end
 
 
end
