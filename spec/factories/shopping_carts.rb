# frozen_string_literal: true

# == Schema Information
#
# Table name: shopping_carts
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  product_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_shopping_carts_on_product_id  (product_id)
#  index_shopping_carts_on_user_id     (user_id)
#
FactoryBot.define do
  factory :shopping_cart do
    user_id { 1 }
    product_id { 1 }
  end
end
