class Boolean < ActiveRecord::Migration
  def change
    change_column_default :orders, :result, false
  end
end
