class BedController < ApplicationController

  layout "doctor_admin"

  before_action :confirm_logged_in
  
  

  def index
    @beds = Bed.sorted
    @bed_number = Bed.pluck(:bednumber).last      


  end

  def show
    @bed = Bed.find(params[:id])
  end

  def new
    @bed = Bed.new({:name => "Default"})
    @bed_count = Bed.count + 1
  end

  def create
  # Instantiate a new object using form parameters 
   @bed = Bed.new(bed_params)
   @check_bed_number = Bed.where(:wardtype => @bed.wardtype, :bednumber => @bed.bednumber)
   #flash[:error] =  "." + @check_bed_number.inspect + @check_bed_number.empty?.to_s
   #redirect_to(:action => 'index')
    if @check_bed_number.empty?
     
        # Save the object
        if @bed.save
          # If save succeeds, redirect to the index action
          flash[:notice] = "bed added "

          @bed_add_rate = Bed.find(@bed.id)
          
          if @bed_add_rate.wardtype == "Standard Ward"

            @bed_add_rate.dailyrate = "50.00"
           elsif @bed_add_rate.wardtype == "Standard +"

            @bed_add_rate.dailyrate = "70.00"
           elsif @bed_add_rate.wardtype == "Intensive Care Unit (ICU)"

            @bed_add_rate.dailyrate = "0.00"
           elsif @bed_add_rate.wardtype == "Maternity"

            @bed_add_rate.dailyrate = "150.00"
           elsif @bed_add_rate.wardtype == "Paediatric"

            @bed.dailyrate = "200.00"
           elsif @bed_add_rate.wardtype == "Semi Private Ward"

            @bed_add_rate.dailyrate = "70.00"
           elsif @bed_add_rate.wardtype == "Private Room"

            @bed_add_rate.dailyrate = "650.00"
           else
              @bed_add_rate.wardtype = "Standard Ward"
         end

          #@bed_add_rate.dailyrate = @bed_add_rate.dailyrate
          #flash[:error] =  "error " + @bed_add_rate.dailyrate.to_s
          @bed_add_rate.update_attributes("dailyrate"=>@bed_add_rate.dailyrate)
          
          redirect_to(:action => 'index')
          else
            @bed_count = Bed.count + 1
            # If save fails, redisplay the form so user can fix problems
            flash[:error] = "Error. Bed not added"
            redirect_to(:action => 'index')
        end

    else
      flash[:error] = "Error. Bed 0" + @bed.bednumber.to_s + " already exists in " + @bed.wardtype.to_s
      redirect_to(:action => 'index')
    end
  end

  def edit
    @bed = Bed.find(params[:id])
    @bed_count = Bed.count
  end

  def update
    # Find an existing object using form parameters  
    @bed = Bed.find(params[:id])
    @bed_check = Bed.new(bed_params)
    
    #check if bed already exists
    @check_bed_number = Bed.where(:wardtype => @bed_check.wardtype, :bednumber => @bed_check.bednumber).where.not(:id => params[:id])
    #flash[:error] =  "." + @check_bed_number.inspect + @check_bed_number.empty?.to_s
    #redirect_to(:action => 'edit', :id => params[:id])

     if @check_bed_number.empty?

       # Update the object
      if  @bed.update_attributes(bed_params)
        # If update succeeds, redirect to the index action
        flash[:notice] = "bed's details updated"
        redirect_to(:action => 'show', :id => @bed.id)
      else
        @bed_count = Bed.count
      # If update fails, redisplay the form so user can fix problems
      flash[:error] = "Error. Bed not added"
      redirect_to(:action => 'edit', :id => params[:id])
      end

    else
      flash[:error] = "Error. Bed 0" + @bed_check.bednumber.to_s + " already exists in " + @bed_check.wardtype.to_s
      redirect_to(:action => 'edit', :id => params[:id])
    end
  end

  def delete
    @bed = Bed.find(params[:id])

  end

  def destroy
    bed = Bed.find(params[:id]).destroy
    flash[:notice] = "Bed deleted successfully"
    redirect_to(:action => 'index')
    
  end

  private 

  def bed_params
        # same as using "params[:bed]", except that it:
        # - raises an error if :bed is not present
        # - allows listed attributes to be mass assigned

        params.require(:bed).permit(:nurse_id, :bednumber, :wardtype, :dailyrate, :deposit, :description, :status, :created_at)
    end
end
