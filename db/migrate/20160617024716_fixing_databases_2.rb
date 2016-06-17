class FixingDatabases2 < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.rename :user, :user_id
      t.rename :game, :game_id
    end
    change_table :games do |t|
      t.rename :user, :user_id
    end
  end
end
