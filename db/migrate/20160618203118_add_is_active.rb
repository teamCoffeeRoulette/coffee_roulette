class AddIsActive < ActiveRecord::Migration
  def change
    add_column :games, :is_active, :boolean 
    change_column_default :games, :is_active, true
  end
end
