class DoctorController < ApplicationController
  
  layout "admin"

  before_action :confirm_logged_in

  def index
    @doctors = Doctor.sorted
  end

  def show
    @doctor = Doctor.find(params[:id])
  end

  def new
    @doctor = Doctor.new({:name => "Default"})
    @doctor_count = Doctor.count + 1
  end

  def create
  # Instantiate a new object using form parameters  
   #@doctor.password => :password
   @doctor = Doctor.new(doctor_params)
   
      # Save the object
      if @doctor.save
        # If save succeeds, redirect to the index action
        flash[:notice] = "doctor added successfully"
        redirect_to(:action => 'index')
        else
          @doctor_count = Doctor.count + 1
          # If save fails, redisplay the form so user can fix problems
          render('index')
      end
  end

  def edit
    @doctor = Doctor.find(params[:id])
    @doctor_count = Doctor.count
  end

  def update
     # Find an existing object using form parameters  
     @doctor = Doctor.find(params[:id])
     #@doctor.password => :password
     # Update the object
    if  @doctor.update_attributes(doctor_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "doctor's details updated successfully"
      redirect_to(:action => 'show', :id => @doctor.id)
    else
      @doctor_count = Doctor.count
    # If update fails, redisplay the form so user can fix problems
    render('edit')
    end
  end

  def delete
    @doctor = Doctor.find(params[:id])

  end

  def destroy
    doctor = Doctor.find(params[:id]).destroy
    flash[:notice] = "Doctor '#{doctor[:name]}' deleted successfully"
    redirect_to(:action => 'index')
    
  end

  private 

  def doctor_params
        # same as using "params[:doctor]", except that it:
        # - raises an error if :doctor is not present
        # - allows listed attributes to be mass assigned

        params.require(:doctor).permit(:name, :email, :password, :department_id, :address, :phone, :gender, :postcode, :profile, :department_name, :created_at)
    end
 
end
