class FixIds < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.rename :user_id_id, :user
      t.rename :game_id_id, :game
    end
    change_table :games do |t|
      t.rename :user_id_id, :user
    end
  end
end
