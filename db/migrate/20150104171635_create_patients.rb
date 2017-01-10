class CreatePatients < ActiveRecord::Migration
  def up
    create_table :patients do |t|
      t.column "name", :string, :limit => 100
      t.string "email", :default => "", :null => false
      t.string "password", :limit => 40
      t.string "address", :limit => 100
      t.string "postcode", :limit => 10
      t.string "phone", :limit => 20
      t.string "gender", :limit => 6
      t.string "bloodgroup", :limit => 5
      t.string "dateofbirth", :limit => 6
      t.string "maritalstatus", :limit => 20
      t.string "occupation", :limit => 50
      #t.datetime "created_at"
      #t.datetime "created_at"
      t.timestamps
    end
  end

  def down
  	drop_table :patients
  end
end
