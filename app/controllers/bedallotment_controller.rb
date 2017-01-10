class BedallotmentController < ApplicationController
 
  layout "doctor_admin"

  before_action :confirm_logged_in

  
  def index
  	@alloted_beds = Bedallotment.sorted
  end

  def show
  	@alloted_bed = Bedallotment.find(params[:id])
  end

  def new
  	@alloted_bed = Bedallotment.new({:name => "Default"})
  	@alloted_bed_count = Bedallotment.count + 1
  end

  def create
  # Instantiate a new object using form parameters  
  @alloted_bed = Bedallotment.new(alloted_bed_params)

  if @alloted_bed.allotmentdate < @alloted_bed.dischargedate

  		# Save the object
    	if @alloted_bed.save
    		# If save succeeds, redirect to the index action
    		flash[:notice] = "Bed alloted"
    	#update bed status to unavailable	
    		@update_bed = Bed.find(@alloted_bed.bed_id)
    		@update_bed.update_attributes(:status => "unavailable")
    		redirect_to(:action => 'index')
    		else
   				@alloted_bed_count = Bedallotment.count + 1
    			# If save fails, redisplay the form so user can fix problems
    			flash[:error] = "Error. Bed allotment failed"
    			redirect_to(:action => 'index')
    	end
    else
    	flash[:error] = "Error. Discharge date must be after Allocation date"
    	redirect_to(:action => 'index')
    end
	end

  def edit
  	@alloted_bed = Bedallotment.find(params[:id])
  	@alloted_bed_count = Bedallotment.count
  end

  def update
     # Find an existing object using form parameters  
     @alloted_bed = Bedallotment.find(params[:id])
     # Update the object
    if  @alloted_bed.update_attributes(alloted_bed_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "Bed allotment updated "
      redirect_to(:action => 'show', :id => @alloted_bed.id)
    else
      @alloted_bed_count = Bedallotment.count
    # If update fails, redisplay the form so user can fix problems
    render('edit')
    end
  end

  def delete
    @alloted_bed = Bedallotment.find(params[:id])

  end

  def destroy
  	@alloted_bed = Bedallotment.find(params[:id])

    #update bed status to available	
    		@update_bed = Bed.find(@alloted_bed.bed.id)
    		@update_bed.update_attributes(:status => "available")
    alloted_bed = Bedallotment.find(params[:id]).destroy
    flash[:notice] = "Bed allotment deleted"
    redirect_to(:action => 'index')
    
  end

 	private 

 	def alloted_bed_params
        # same as using "params[:alloted_bed]", except that it:
        # - raises an error if :alloted_bed is not present
        # - allows listed attributes to be mass assigned

        params.require(:alloted_bed).permit(:bed_id, :patient_id, :allotmentdate, :dischargedate, :alloted_by, :created_at)
    end
 

end
