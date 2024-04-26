class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.bigint :user_id
      t.integer :total_price_cents
      t.string :total_price_currency

      t.timestamps
    end
  end
end
