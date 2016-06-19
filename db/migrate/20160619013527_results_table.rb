class ResultsTable < ActiveRecord::Migration
  def change
    drop_table :orders

    create_table :orders do |t|
      t.references :user
      t.references :game
      t.boolean :result
      t.timestamps
    end
  end
end
