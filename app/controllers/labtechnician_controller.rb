class LabtechnicianController < ApplicationController
  
  layout "admin"

  before_action :confirm_logged_in

  def index
    @labtechnicians = Labtechnician.sorted
  end

  def show
    @labtechnician = Labtechnician.find(params[:id])
  end

  def new
    @labtechnician = Labtechnician.new({:name => "Default"})
    @labtechnician_count = Labtechnician.count + 1
  end

  def create
  # Instantiate a new object using form parameters  
   @labtechnician = Labtechnician.new(labtechnician_params)

      # Save the object
      if @labtechnician.save
        # If save succeeds, redirect to the index action
        flash[:notice] = "labtechnician added successfully"
        redirect_to(:action => 'index')
        else
          @labtechnician_count = Labtechnician.count + 1
          # If save fails, redisplay the form so user can fix problems
          render('index')
      end
  end

  def edit
    @labtechnician = Labtechnician.find(params[:id])
    @labtechnician_count = Labtechnician.count
  end

  def update
     # Find an existing object using form parameters  
     @labtechnician = Labtechnician.find(params[:id])
     # Update the object
    if  @labtechnician.update_attributes(labtechnician_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "labtechnician's details updated successfully"
      redirect_to(:action => 'show', :id => @labtechnician.id)
    else
      @labtechnician_count = Labtechnician.count
    # If update fails, redisplay the form so user can fix problems
    render('edit')
    end
  end

  def delete
    @labtechnician = Labtechnician.find(params[:id])

  end

  def destroy
    labtechnician = Labtechnician.find(params[:id]).destroy
    flash[:notice] = "Labtechnician '#{labtechnician[:name]}' deleted successfully"
    redirect_to(:action => 'index')
    
  end

  private 

  def labtechnician_params
        # same as using "params[:labtechnician]", except that it:
        # - raises an error if :labtechnician is not present
        # - allows listed attributes to be mass assigned

        params.require(:labtechnician).permit(:name, :email, :password, :department_id, :address, :phone, :gender, :postcode, :profile, :created_at)
    end
 
end
