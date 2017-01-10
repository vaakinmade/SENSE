class CreateBedallotments < ActiveRecord::Migration
 def up
    create_table :bedallotments do |t|
      t.column "bed_id", :int
      t.column "patient_id", :int
      t.column "alloted_by", :string, :limit => 20
      t.column "allotmentdate", :date
      t.column "dischargedate", :date
      #t.datetime "created_at"
      #t.datetime "updated_at"
      t.timestamps
    end
  end

   def down
  	drop_table :bedallotments
  end
end
