class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string :title, null: false
      t.string :url, null: false

      t.timestamps
    end

    add_index :publishers, :title, unique: true
    add_index :publishers, :url, unique: true
  end
end
