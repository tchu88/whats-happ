class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :message, null: false
      t.decimal :longitude, precision: 9, scale: 6, null: false
      t.decimal :latitude, precision: 9, scale: 6, null: false

      t.timestamps
    end
  end
end
