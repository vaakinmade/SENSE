class PharmacistController < ApplicationController
  
  layout "admin"

  before_action :confirm_logged_in

  def index
    @pharmacists = Pharmacist.sorted
  end

  def show
    @pharmacist = Pharmacist.find(params[:id])
  end

  def new
    @pharmacist = Pharmacist.new({:name => "Default"})
    @pharmacist_count = Pharmacist.count + 1
  end

  def create
  # Instantiate a new object using form parameters  
   @pharmacist = Pharmacist.new(pharmacist_params)

      # Save the object
      if @pharmacist.save
        # If save succeeds, redirect to the index action
        flash[:notice] = "pharmacist added successfully"
        redirect_to(:action => 'index')
        else
          @pharmacist_count = Pharmacist.count + 1
          # If save fails, redisplay the form so user can fix problems
          render('index')
      end
  end

  def edit
    @pharmacist = Pharmacist.find(params[:id])
    @pharmacist_count = Pharmacist.count
  end

  def update
     # Find an existing object using form parameters  
     @pharmacist = Pharmacist.find(params[:id])
     # Update the object
    if  @pharmacist.update_attributes(pharmacist_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "pharmacist's details updated successfully"
      redirect_to(:action => 'show', :id => @pharmacist.id)
    else
      @pharmacist_count = Pharmacist.count
    # If update fails, redisplay the form so user can fix problems
    render('edit')
    end
  end

  def delete
    @pharmacist = Pharmacist.find(params[:id])

  end

  def destroy
    pharmacist = Pharmacist.find(params[:id]).destroy
    flash[:notice] = "Pharmacist '#{pharmacist[:name]}' deleted successfully"
    redirect_to(:action => 'index')
    
  end

  private 

  def pharmacist_params
        # same as using "params[:pharmacist]", except that it:
        # - raises an error if :pharmacist is not present
        # - allows listed attributes to be mass assigned

        params.require(:pharmacist).permit(:name, :email, :password, :department_id, :address, :phone, :gender, :postcode, :profile, :created_at)
    end
 
end
