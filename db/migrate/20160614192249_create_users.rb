class CreateUsers < ActiveRecord::Migration

  create_table :users, force: true do |t|
    t.string :email
    t.string :display_name
    t.string :password_hash
    t.timestamps
  end

end
