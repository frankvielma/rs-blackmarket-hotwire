# frozen_string_literal: true

class CreateLineItems < ActiveRecord::Migration[7.1]
  def change
    create_table :line_items do |t|
      t.bigint :shopping_cart_id
      t.bigint :order_id
      t.bigint :product_id
      t.integer :quantity

      t.timestamps
    end
  end
end
