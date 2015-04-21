class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :user_id, null: false
      t.string :email, null: false
      t.decimal :cost, precision: 8, scale: 2, default: 0.0, null: false
      t.string :state, null: false
      t.datetime :deleted_at
      t.hstore :product_cart, default: {}

      t.timestamps
    end

    add_index :invoices, :created_at, using: :btree

    create_table :products_invoices, :id => false do |t|
      t.integer :product_id, null: false
      t.integer :invoice_id, null: false
    end

    add_index :products_invoices, [:product_id, :invoice_id], using: :btree
  end
end
