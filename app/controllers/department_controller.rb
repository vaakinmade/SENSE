class DepartmentController < ApplicationController
  
  layout "admin"

  before_action :confirm_logged_in

  def index
  	@departments = Department.sorted
  end

  def show
  	@department = Department.find(params[:id])
  end

  def new
  	@department = Department.new({:name => "Default"})
  	@department_count = Department.count + 1
  end

  def create
  # Instantiate a new object using form parameters  
  @department = Department.new(department_params)

  		# Save the object
    	if @department.save
    		# If save succeeds, redirect to the index action
    		flash[:notice] = "department created successfully"
    		redirect_to(:action => 'index')
    		else
   				@department_count = Department.count + 1
    			# If save fails, redisplay the form so user can fix problems
    			render('index')
    	end
	end

  def edit
  	@department = Department.find(params[:id])
  	@department_count = Department.count
  end

  def update
     # Find an existing object using form parameters  
     @department = Department.find(params[:id])
     # Update the object
    if  @department.update_attributes(department_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "department updated successfully"
      redirect_to(:action => 'show', :id => @department.id)
    else
      @department_count = Department.count
    # If update fails, redisplay the form so user can fix problems
    render('edit')
    end
  end

  def delete
    @department = Department.find(params[:id])

  end

  def destroy
    department = Department.find(params[:id]).destroy
    flash[:notice] = "Department '#{department[:name]}' deleted successfully"
    redirect_to(:action => 'index')
    
  end

 	private 

 	def department_params
        # same as using "params[:department]", except that it:
        # - raises an error if :department is not present
        # - allows listed attributes to be mass assigned

        params.require(:department).permit(:name, :description, :created_at)
    end
 

end
