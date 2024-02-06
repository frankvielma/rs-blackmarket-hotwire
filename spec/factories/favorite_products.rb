# frozen_string_literal: true

# == Schema Information
#
# Table name: favorite_products
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  product_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_favorite_products_on_product_id  (product_id)
#  index_favorite_products_on_user_id     (user_id)
#
FactoryBot.define do
  factory :favorite_product do
    user { nil }
    product { nil }
  end
end
