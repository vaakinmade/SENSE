class Appointment < ActiveRecord::Base

	belongs_to :doctor
  #belongs_to :nurse
	belongs_to :patient

	#scope :booked, lambda { where(:id != nil) }
	scope :sorted, lambda { order("appointments.created_at DESC") }
	
	scope :search_doc, lambda {
		where(["doctor.name LIKE ?", session[:name]])
	}

	scope :search_patient, lambda {|query|
		where(["patient.name LIKE ?", "%#{query}%"])
	}

 # def sched_time_field=(time)
  # Change back to datetime friendly format
  #:start => Time.parse(self.start).strftime("%H:%M:%S")
 # end

  def as_json(options = {})
    {
         # strftime('%Y-%m-%d %H:%M:%S')
         :id => self.id,
         :patient_id => self.patient_id,
         :doctor_id => self.doctor_id,
         :title => "#{self.patient.name}" + " - Dr. #{self.doctor.name.split.second}",
         :date => self.date,
         :start => self.start.strftime("%Y-%m-%d %H:%M:%S"),
         :end => self.end.strftime("%Y-%m-%d %H:%M:%S"),
         :allDay => false
         
         #:start => start.strftime("%H:%M:%S")
      }
  end

	# def self.between(start_time, end_time)
 #    where('time > :lo and time < :up',
 #      :lo => Appointment.format_date(start_time),
 #      :up => Appointment.format_date(end_time)
 #    )
 #  end

 #  def self.format_date(date_time)
 #   Time.at(date_time.to_i).to_formatted_s(:db)
 #  end

  # def as_json(options = {})
  #   {
  #   	#@appointments = Appointment.joins(:doctor).where(doctors: { name: session[:name]}).sorted

  #     :id => self.id,
  #     :title => self.title,
  #     :start => time.rfc822,
  #     :end => nil,
  #     :allDay => allDay,
  #     :user_name => nil,
  #     :url => Rails.application.routes.url_helpers.events_path(id),
  #     :color => "green"
  #   }
  # end


end
