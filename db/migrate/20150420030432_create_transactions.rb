class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id, null: false
      t.string :type, null: false
      t.decimal :value, precision: 8, scale: 2, default: 0.0, null: false
      t.string :state, null: false
      t.datetime :deleted_at
      t.integer :target_id
      t.string :target_type

      t.timestamps
    end
  end
end
