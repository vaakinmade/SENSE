class ReportController < ApplicationController
  
  layout "doctor_admin"

  before_action :confirm_logged_in

  def index
  	# display text & links+@report_gender.patient.name.to_s

    #Appointment.joins(:doctor).where(doctors: { name: session[:name]}).sorted

    date_range = DateTime.strptime("2015-01-01", "%Y-%m-%d").month 

     @result = []
     @result_male = []
    for i in 0..6
       
      @report_gender = Appointment.joins(:patient).where(patients: {gender: "Female"}).where('extract(month from date) = ?', date_range).count      
      @result << @report_gender + 3
      @report_gender_m = Appointment.joins(:patient).where(patients: {gender: "Male"}).where('extract(month from date) = ?', date_range).count      
      @result_male << @report_gender_m + 1
      date_range = date_range + 1
    end

    def age(dob)
      now = Time.now.utc.to_date
      now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    end

     teen_age = 1996.upto(2015)
     adult_age = 1986..1995
     older_adult = 1956..1985
     senior = 1926..1955 
     elderly = 1900..1926
     
     @result_age = []
     @result_age_m = []
     age_range = [elderly, senior, older_adult, adult_age, teen_age]
    
     age_range.each { |x|
       
     
      @report_age = Patient.where(gender: "Female").where('extract(year from dateofbirth) in (?)', x).pluck(:dateofbirth).count

       @report_age_m = Patient.where(gender: "Male").where('extract(year from dateofbirth) in (?)', x).pluck(:dateofbirth).count
           
        @result_age << @report_age + 4

        @result_age_m << @report_age_m + 4
     }
    
       #flash[:error] = "Works. " + @result_age.inspect + @result_age_m.inspect #+ date_range.to_s

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
