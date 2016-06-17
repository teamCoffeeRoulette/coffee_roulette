class CreateOrders < ActiveRecord::Migration

  create_table :orders do |t|
    t.reference :user_id
    t.reference :game_id
    t.timestamps
  end

end
