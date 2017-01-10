class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.column "admin_id", :int
      t.column "doctor_id", :int
      t.column "nurse_id", :int
      t.column "pharmacist_id", :int
      t.column "lab_technician_id", :int  
      t.column "accountant_id", :int
      t.column "patient_id", :int
      #t.datetime "created_at"
      #t.datetime "created_at"
      t.timestamps
    end
  end

  def down
  	drop_table :users
  end
end
