class PatientController < ApplicationController
  
  layout "doctor_admin"

  before_action :confirm_logged_in

   def index
    @patients = Patient.sorted
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def new
    @patient = Patient.new({:name => "Default"})
    @patient_count = Patient.count + 1
  end

   def create
  # Instantiate a new object using form parameters  
   @patient = Patient.new(patient_params)

      # Save the object
      if @patient.save
        # If save succeeds, redirect to the index action
        flash[:notice] = "Patient added successfully"
        redirect_to(:action => 'index')
        else
          @patient_count = Patient.count + 1
          # If save fails, redisplay the form so user can fix problems
           @patients = Patient.sorted
          render('index')
      end
  end


  def edit
    @patient = Patient.find(params[:id])
    @patient_count = Patient.count
  end

  def update
     # Find an existing object using form parameters  
     @patient = Patient.find(params[:id])
     # Update the object
    if  @patient.update_attributes(patient_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "patient's details updated successfully"
      redirect_to(:action => 'show', :id => @patient.id)
    else
      @patient_count = Patient.count
       @patients = Patient.sorted
    # If update fails, redisplay the form so user can fix problems
    render(:action => 'edit', :id => params[:id])
    end
  end

  def delete
    @patient = Patient.find(params[:id])

  end

  def destroy
    patient = Patient.find(params[:id]).destroy
    flash[:notice] = "Patient '#{patient[:name]}' deleted successfully"
    redirect_to(:action => 'index')
    
  end

  private 

  def patient_params
        # same as using "params[:patient]", except that it:
        # - raises an error if :doctor is not present
        # - allows listed attributes to be mass assigned

        params.require(:patient).permit(:name, :email, :address, :postcode, :phone, :gender, :bloodgroup, :dateofbirth, :maritalstatus, :occupation, :created_at)
    end

end
