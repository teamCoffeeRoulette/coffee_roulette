class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user_id
      t.references :game_id
      t.timestamps
    end
  end

end
