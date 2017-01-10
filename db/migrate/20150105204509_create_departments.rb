class CreateDepartments < ActiveRecord::Migration
  def up
      create_table :departments do |t|
      t.column "admin_id", :int
      t.column "name", :string, :limit => 100
      t.column "description", :text
      #t.datetime "created_at"
      #t.datetime "created_at"
      t.timestamps
  	  end
  end

   def down
  	drop_table :departments
  end

end

