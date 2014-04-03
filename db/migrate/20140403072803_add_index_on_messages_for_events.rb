class AddIndexOnMessagesForEvents < ActiveRecord::Migration
  def change
    add_index :events, :message, unique: true
  end
end
