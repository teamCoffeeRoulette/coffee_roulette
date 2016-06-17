class FixIds < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.rename :user_id_id, :user_id
      t.rename :game_id_id, :game_id
    end
    change_table :games do |t|
      t.rename :user_id_id, :user_id
    end
  end
end
