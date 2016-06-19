class AddRelations < ActiveRecord::Migration
  def change
    drop_table :orders

    create_table :orders do |t|
      t.references :user
      t.references :game
    end
  end
end
