class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :product_images do |t|
      t.integer :product_id
      t.string :asset, null: false
      t.boolean :main, default: false, null: false
    end
  end
end
