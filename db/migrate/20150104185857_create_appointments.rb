class CreateAppointments < ActiveRecord::Migration
  def up
    create_table :appointments do |t|
      t.references :patient
      t.references :doctor
      #t.references :nurse
      t.string "title", :limit => 100
      t.column "time", :time
      t.column "date", :date
      t.timestamps
    end
    add_index :appointments, ["patient_id", "doctor_id", "nurse_id"]
  end

  def down
  	drop_table :appointments
  end

end
