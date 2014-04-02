class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :phone, null: false
      t.integer :radius, null: false
      t.decimal :longitude, precision: 9, scale: 6, null: false
      t.decimal :latitude, precision: 9, scale: 6, null: false

      t.timestamps
    end

    add_index :subscriptions, :phone
  end
end
