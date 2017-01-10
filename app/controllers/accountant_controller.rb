class AccountantController < ApplicationController
  
  layout "admin"

  before_action :confirm_logged_in

  def index
    @accountants = Accountant.sorted
  end

  def show
    @accountant = Accountant.find(params[:id])
  end

  def new
    @accountant = Accountant.new({:name => "Default"})
    @accountant_count = Accountant.count + 1
  end

  def create
  # Instantiate a new object using form parameters  
   @accountant = Accountant.new(accountant_params)

      # Save the object
      if @accountant.save
        # If save succeeds, redirect to the index action
        flash[:notice] = "accountant added successfully"
        redirect_to(:action => 'index')
        else
          @accountant_count = Accountant.count + 1
          # If save fails, redisplay the form so user can fix problems
          render('index')
      end
  end

  def edit
    @accountant = Accountant.find(params[:id])
    @accountant_count = Accountant.count
  end

  def update
     # Find an existing object using form parameters  
     @accountant = Accountant.find(params[:id])
     # Update the object
    if  @accountant.update_attributes(accountant_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "accountant's details updated successfully"
      redirect_to(:action => 'show', :id => @accountant.id)
    else
      @accountant_count = Accountant.count
    # If update fails, redisplay the form so user can fix problems
    render('edit')
    end
  end

  def delete
    @accountant = Accountant.find(params[:id])

  end

  def destroy
    accountant = Accountant.find(params[:id]).destroy
    flash[:notice] = "Accountant '#{accountant[:name]}' deleted successfully"
    redirect_to(:action => 'index')
    
  end

  private 

  def accountant_params
        # same as using "params[:accountant]", except that it:
        # - raises an error if :accountant is not present
        # - allows listed attributes to be mass assigned

        params.require(:accountant).permit(:name, :email, :password, :department_id, :address, :phone, :gender, :postcode, :created_at)
    end
 
end
