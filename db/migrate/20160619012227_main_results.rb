class MainResults < ActiveRecord::Migration
  def change
    add_column :orders, :result, :boolean
  end
end
