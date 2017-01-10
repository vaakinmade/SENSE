class CreateHospitals < ActiveRecord::Migration
  def up
    create_table :hospitals do |t|
      t.column "hospitalname", :string, :limit => 100
      t.column "adminid", :int
      t.string "systemname", :limit => 100
      t.string "email", :default => "", :null => false
      t.string "address", :limit => 100
      t.string "phone", :limit => 20

      #t.datetime "created_at"
      #t.datetime "created_at"
      t.timestamps
    end
  end

   def down
  	drop_table :hospitals
  end

end
