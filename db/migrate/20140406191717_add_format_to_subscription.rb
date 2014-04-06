class AddFormatToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :format, :string, null: false, default: ''
  end
end
