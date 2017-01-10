class NurseController < ApplicationController
  
  layout "admin"
  
  before_action :confirm_logged_in

  def index
    @nurses = Nurse.sorted
  end

  def show
    @nurse = Nurse.find(params[:id])
  end

  def new
    @nurse = Nurse.new({:name => "Default"})
    @nurse_count = Nurse.count + 1
  end

  def create
  # Instantiate a new object using form parameters  
   @nurse = Nurse.new(nurse_params)

      # Save the object
      if @nurse.save
        # If save succeeds, redirect to the index action
        flash[:notice] = "nurse added successfully"
        redirect_to(:action => 'index')
        else
          @nurse_count = Nurse.count + 1
          # If save fails, redisplay the form so user can fix problems
          render('index')
      end
  end

  def edit
    @nurse = Nurse.find(params[:id])
    @nurse_count = Nurse.count
  end

  def update
     # Find an existing object using form parameters  
     @nurse = Nurse.find(params[:id])
     # Update the object
    if  @nurse.update_attributes(nurse_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "nurse's details updated successfully"
      redirect_to(:action => 'show', :id => @nurse.id)
    else
      @nurse_count = Nurse.count
    # If update fails, redisplay the form so user can fix problems
    render('edit')
    end
  end

  def delete
    @nurse = Nurse.find(params[:id])

  end

  def destroy
    nurse = Nurse.find(params[:id]).destroy
    flash[:notice] = "Nurse '#{nurse[:name]}' deleted successfully"
    redirect_to(:action => 'index')
    
  end

  private 

  def nurse_params
        # same as using "params[:nurse]", except that it:
        # - raises an error if :nurse is not present
        # - allows listed attributes to be mass assigned

        params.require(:nurse).permit(:name, :email, :password, :department_id, :address, :phone, :gender, :postcode, :specialty, :created_at)
    end
 
end
