# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :state
      t.integer :stock
      t.integer :unit_price_cents
      t.integer :unit_price_currency, default: 0
      t.integer :category_id

      t.timestamps
    end
  end
end
