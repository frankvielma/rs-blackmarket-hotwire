# frozen_string_literal: true

class ProductAddDefaults < ActiveRecord::Migration[7.1]
  def up
    change_table :products, bulk: true do |t|
      t.change_default :state, from: nil, to: 0
      t.change_default :stock, from: nil, to: 0
      t.change_default :unit_price_cents, from: nil, to: 0
    end
  end

  def down
    change_table :products, bulk: true do |t|
      t.change_default :state, from: 0, to: nil
      t.change_default :stock, from: 0, to: nil
      t.change_default :unit_price_cents, from: 0, to: nil
    end
  end
end
