class Songs < ActiveRecord::Migration
  create_table :songs do |t|
    t.references :user
    t.string     :title
    t.string     :artist
    t.timestamps
  end
end
