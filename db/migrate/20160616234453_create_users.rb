class CreateUsers < ActiveRecord::Migration
  create_table :users do |t|
    t.string :email
    t.string :display_name
    t.string :password_hash
    t.string :phone_number
    t.string :drink
    t.timestamps
  end
end
