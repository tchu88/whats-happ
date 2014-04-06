class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :event_id, null: false
      t.integer :subscription_id, null: false
      t.string :format, null: false
      t.datetime :succeeded_at

      t.timestamps
    end

    add_index :notifications, [:event_id, :subscription_id], unique: true
  end
end
