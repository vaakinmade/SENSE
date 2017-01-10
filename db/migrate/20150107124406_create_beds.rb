class CreateBeds < ActiveRecord::Migration
  def up
    create_table :beds do |t|
      t.column "nurse_id", :int
      t.column "bednumber", :int
      t.string "wardtype", :limit => 50
      t.string "wardcategory", :limit => 50
      t.column "dailyrate", :decimal
      t.column "deposit", :decimal
      t.column "description", :text
      t.string "status", :limit => 20
      #t.datetime "created_at"
      #t.datetime "created_at"
      t.timestamps
    end
  end

   def down
  	drop_table :beds
  end
end
