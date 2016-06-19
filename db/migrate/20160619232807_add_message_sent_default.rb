class AddMessageSentDefault < ActiveRecord::Migration
  def change
    change_column_default :games, :message, false
  end
end
