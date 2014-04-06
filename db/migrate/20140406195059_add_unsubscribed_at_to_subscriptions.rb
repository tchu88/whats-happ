class AddUnsubscribedAtToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :unsubscribed_at, :datetime
    add_index :subscriptions, :unsubscribed_at
  end
end
