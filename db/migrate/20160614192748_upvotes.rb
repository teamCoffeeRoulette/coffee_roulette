class Upvotes < ActiveRecord::Migration

  create_table :upvotes do |t|
    t.references :user
    t.references :song
    t.timestamps
  end

end
