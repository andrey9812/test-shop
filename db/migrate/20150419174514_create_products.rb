class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.text :description
      t.string :maker
      t.integer :count, default: 0, null: false
      t.decimal :price, precision: 8, scale: 2, default: 0.0, null: false
      t.hstore :properties, default: {}
      t.string :state

      t.timestamps
    end
  end
end
