class AddMessageSent < ActiveRecord::Migration
  def change
    add_column :games, :message, :boolean
  end
end
