class DashboardController < ApplicationController
  
  layout "doctor_admin"

  before_action :confirm_logged_in

  def index
     @appointments_dash = Appointment.count
     @patient_dash = Patient.count
     @bed_allotment_dash = Bedallotment.count 
     @bed_dash = Bed.count


     @appointments_doc_cancelled = Appointment.joins(:doctor).where(doctors: { name: session[:name]}).where(:cancelled => "true").sorted.size
     @appointments_cancelled = Appointment.where(:cancelled => "true").sorted
     @appointments_doc_dash = Appointment.joins(:doctor).where(doctors: { name: session[:name]}).where.not(:cancelled => "true").sorted

  end

  def lock
    #redirect_to(:controller => 'appointment', :action => 'index')
  end

  def show
  	
  end

  def new
  	
  end

  def create
  # Instantiate a new object using form parameters  
 
	end

  def edit
  	
  end

  def update
     
  end

  def delete
    

  end

  def destroy
   
    
  end

 	private 

 	def department_params
        # same as using "params[:department]", except that it:
        # - raises an error if :department is not present
        # - allows listed attributes to be mass assigned

        params.require(:department).permit(:name, :description, :created_at)
    end
 

end
