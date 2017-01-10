class AppointmentController < ApplicationController
 
layout "doctor_admin"

before_action :confirm_logged_in

  #respond_to :html, :js
  #respond_to :html, :xml, :json, :js

  def index
    @appointments = Appointment.joins(:doctor).where(doctors: { name: session[:name]}).where.not(:cancelled => "true").sorted
    @check_nurse = Nurse.where(:name => session[:name]).first
  
    if params[:active_true] 
      @appointment = Appointment.new(appointment_params)
      if  @appointment.doctor_id
          session[:event_doc_id] = @appointment.doctor_id
          @appointment_filter = Appointment.joins(:doctor).where(doctors: { id: @appointment.doctor_id}).first
          session[:selected_option] = @appointment_filter.doctor.name
      else
          session[:event_doc_id] = nil
          session[:selected_option] = "All Doctors"
          end
    end

    if session[:event_doc_id] && !@check_nurse
      session[:events] = Appointment.joins(:doctor).where(doctors: { id: session[:event_doc_id] }).sorted
      @events = session[:events]
      #flash[:error] = "Error 2. ";
     
     elsif @check_nurse && session[:event_doc_id]
       @appointments = Appointment.sorted
       session[:events] = Appointment.joins(:doctor).where(doctors: { id: session[:event_doc_id] }).where.not(:cancelled => "true").sorted
           @events = session[:events]
          # flash[:error] = "Error 3. ";

     elsif @check_nurse && session[:selected_option] == "All Doctors"
       @appointments = Appointment.where.not(:cancelled => "true").sorted
           @events = @appointments
           #flash[:error] = "Error 4. ";
      elsif session[:selected_option] == "All Doctors"
         session[:events] = Appointment.where.not(:cancelled => "true").sorted
         @events = Appointment.sorted #session[:events] 
         #flash[:error] = "Error 11. ";

      else
         @appointments = Appointment.where.not(:cancelled => "true").sorted
      @events = @appointments
   end

     respond_to do |format| 
            format.html
            format.json { render :json => @events } 
     end

 end

  def filter
    if params[:active_true]
      @appointments = Appointment.joins(:doctor).where(doctors: { name: session[:name]}).sorted

      @appointment = Appointment.new(appointment_params)
      
    
       session[:event_doc_id] = @appointment.doctor_id
      
redirect_to('index')
      else
       # redirect_to('index')
    end

  end



  def show
    @appointment = Appointment.find(params[:id])
  end

  def new
    @appointment = Appointment.new
    @appointment_count = Appointment.count + 1
  end

  def create
    
  # Instantiate a new object using form parameters  
  @appointment = Appointment.new(appointment_params)

   
            
  #add 15 minute appointment interval
  @appointment.end = @appointment.start + 15.minutes
    
  if @appointment.end >= (@appointment.start + 15*60)
    
        
        #set 4 minute time interval range
        start_date_time = DateTime.parse("#{@appointment.date} #{@appointment.start}")
        end_date_time = DateTime.parse("#{@appointment.date} #{@appointment.end}")
        time_range = (start_date_time - 19.minutes)..start_date_time + 19.minutes        

        #check for existing appointment within 19 minute range
        @appointment_check = Appointment.where(:doctor_id => @appointment.doctor_id,:date => @appointment.date, :start => time_range).first 
        @appointment_check_patient = Appointment.where(:patient_id => @appointment.patient_id,:date => @appointment.date, :start => time_range).first
        
        #check for similar date and time
        if @appointment_check  

            respond_to do |format|

              flash[:errors] = "Error. " + " Doctor " + @appointment_check.doctor.name + " has an appointment at '" + 
                @appointment_check.start.strftime("%I:%M %p") + "' on '" + @appointment_check.date.strftime("%d %B %Y ") + "'. Please book at least 20 minutes before or after." 
                @appointments = Appointment.joins(:doctor).where(doctors: { name: session[:name]}).sorted
                @check_nurse = Nurse.where(:name => session[:name]).first
          
                if @check_nurse
                  @appointments = Appointment.sorted
                end

              format.html { render 'new', layout: 'doctor_admin'}
              #format.json { render json: flash[:error], status: :unprocessable_entity }
              #format.js   { render action: 'new' }
            end

        elsif @appointment_check_patient  
          
            flash[:errors] = "Error. " + @appointment_check_patient.patient.name  + " has an appointment with Doctor " + @appointment_check_patient.doctor.name + " at '" + 
          @appointment_check_patient.start.strftime("%I:%M %p") + "' on '" + @appointment_check_patient.date.strftime("%d %B %Y ") + "'. Please book at least 20 minutes before or after."
            @appointments = Appointment.joins(:doctor).where(doctors: { name: session[:name]}).sorted
            @check_nurse = Nurse.where(:name => session[:name]).first
          
            if @check_nurse
              @appointments = Appointment.sorted
            end
            
            respond_to do |format|
              format.html { render 'new', layout: 'doctor_admin'}
              #format.js { render json: flash[:error], status: :unprocessable_entity }
            end
        else
            start_date_time = DateTime.parse("#{@appointment.date} #{@appointment.start}")
            end_date_time = DateTime.parse("#{@appointment.date} #{@appointment.end}")

             # Save the object
              if @appointment.save
                # If save succeeds, redirect to the index action
                flash[:notice] = "appointment created"
                @appointment_update = Appointment.find(@appointment.id)
                @appointment_update = @appointment.update_attributes(:start => start_date_time, :end => end_date_time)
                redirect_to(:action => 'index')
              else
                  @appointment_count = Appointment.count + 1
                  # If save fails, redisplay the form so user can fix problems
                  flash[:errors] = "Error. Appointment not saved"
                  @appointments = Appointment.joins(:doctor).where(doctors: { name: session[:name]}).sorted
                  @check_nurse = Nurse.where(:name => session[:name]).first
          
                  if @check_nurse
                    @appointments = Appointment.sorted
                  end
                  render('index')
              end
          end
  else
      flash[:errors] = "Error. Appointment duration should be at least 15 minutes long."
      render('index')
  end
  
  end

  def edit
    @appointment = Appointment.find(params[:id])
    @appointment.start = @appointment.start.strftime("%I:%M %p")
    @appointment_count = Appointment.count
  end

  def update
     # Find an existing object using form parameters  
     @appointment = Appointment.find(params[:id])
     # Get form values
     @appointment_update = Appointment.new(appointment_params)

      #add 15 minute appointment interval
      @appointment_update.end = @appointment_update.start + 15.minutes   
      
      #set 19 minute time interval range
      start_date_time = DateTime.parse("#{@appointment_update.date} #{@appointment_update.start}")
      end_date_time = DateTime.parse("#{@appointment_update.date} #{@appointment_update.end}")
      time_range = (start_date_time - 19.minutes)..start_date_time + 19.minutes

      #check for existing appointment within 19 minute range
      @appointment_check = Appointment.where(:doctor_id => @appointment_update.doctor_id,:date => @appointment_update.date, :start => time_range).where.not(:id => params[:id]).first 
      @appointment_check_patient = Appointment.where(:patient_id => @appointment_update.patient_id,:date => @appointment_update.date, :start => time_range).where.not(:id => params[:id]).first
      
      #check for similar date and time
      if @appointment_check  

          flash[:errors] = "Error. " + " Doctor " + @appointment_check.doctor.name + " has an appointment at '" + 
          @appointment_check.start.strftime("%I:%M %p") + "' on '" + @appointment_check.date.strftime("%d %B %Y ") + "'. Please book at least 20 minutes before or after." 
          render(:action => 'edit', :id => params[:id])

      elsif @appointment_check_patient  
        
          flash[:errors] = "Error. " + @appointment_check_patient.patient.name  + " has an appointment with Doctor " + @appointment_check_patient.doctor.name + " at '" + 
          @appointment_check_patient.start.strftime("%I:%M %p") + "' on '" + @appointment_check_patient.date.strftime("%d %B %Y ") + "'. Please book at least 20 minutes before or after."
          render(:action => 'edit', :id => params[:id])

        else
          #DateTime.parse("#{@sched_date_field} #{@sched_time_field}")
          start_date_time = DateTime.parse("#{@appointment_update.date} #{@appointment_update.start}")
          end_date_time = DateTime.parse("#{@appointment_update.date} #{@appointment_update.end}")

           # Update the object
              if  @appointment.update_attributes(appointment_params)
               # If save succeeds, redirect to the index action
               flash[:notice] = "Appointment updated"
               @appointment.update_attributes(:start => start_date_time, :end => end_date_time)
               redirect_to(:action => 'show', :id => @appointment.id)
             else
                 @appointment_count = Appointment.count + 1
                 # If update fails, redisplay the form so user can fix problems
               
                 flash[:errors] = "Error. Appointment not saved"
                 render(:action => 'edit', :id => params[:id])
             end
        end
  

  end

  def delete
    @appointment = Appointment.find(params[:id])
    @appointments = Appointment.joins(:patient).where(patients: {id:   params[:p_id] }).first
  end

  def destroy
  # appointment = Appointment.find(params[:id]).destroy
   Appointment.destroy(params[:id])
   flash[:notice] = "Appointment deleted"
   # redirect_to(:action => 'index')
   redirect_to(:action => 'index')
  
  #redirect_to 'index' 
   
  end


  def cancel
    @appointment = Appointment.find(params[:id])
    @appointment_update = @appointment.update_attributes(:cancelled => "true")
    flash[:notice] = "Appointment cancelled"
    redirect_to(:action => 'index')
  end

  private 

  def appointment_params
        # same as using "params[:appointment]", except that it:
        # - raises an error if :appointment is not present
        # - allows listed attributes to be mass assigned

        params.require(:appointment).permit(:title, :allDay, :patient_id, :doctor_id, :date, :start, :end, :created_at)
    end
 

end
