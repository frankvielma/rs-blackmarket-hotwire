# frozen_string_literal: true

class CreateShippingAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :shipping_addresses do |t|
      t.string :country
      t.string :city
      t.string :state
      t.string :line1
      t.string :line2
      t.string :postal_code
      t.bigint :order_id

      t.timestamps
    end
  end
end
