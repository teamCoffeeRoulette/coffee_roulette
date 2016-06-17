class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :user_id
      t.timestamps
  end
end
