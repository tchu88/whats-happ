class AddPublisherIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :publisher_id, :integer
    add_index :events, :publisher_id
  end
end
