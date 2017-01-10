class CreatePharmacists < ActiveRecord::Migration
  def up
    create_table :pharmacists do |t|
      t.column "department_id", :int
      t.column "name", :string, :limit => 100
      t.string "email", :default => "", :null => false
      t.string "password", :limit => 40
      t.string "address", :limit => 100
      t.string "postcode", :limit => 10
      t.string "phone", :limit => 20
      t.string "gender", :limit => 6
      t.text "profile"
      #t.datetime "created_at"
      #t.datetime "created_at"
      t.timestamps
    end
  end

   def down
  	drop_table :pharmacists
  end
end
