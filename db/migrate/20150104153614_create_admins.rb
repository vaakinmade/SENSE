class CreateAdmins < ActiveRecord::Migration
  def up
    create_table :admins do |t|
      t.column "name", :string, :limit => 100
      t.column "username", :string, :limit => 100
      t.string "email", :default => "", :null => false
      t.string "department", :limit => 50
      t.string "address", :limit => 100
      t.string "phone", :limit => 20
      #t.datetime "created_at"
      #t.datetime "created_at"
      t.timestamps
    end
  end

  def down
  	drop_table :admins
  end

end
