# frozen_string_literal: true

# == Schema Information
#
# Table name: line_items
#
#  id               :bigint           not null, primary key
#  shopping_cart_id :bigint
#  order_id         :bigint
#  product_id       :bigint
#  quantity         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :line_item do
    shopping_cart_id { '' }
    order_id { '' }
    product_id { '' }
    quantity { 1 }
  end
end
