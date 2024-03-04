# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                  :bigint           not null, primary key
#  title               :string
#  description         :text
#  state               :integer          default("used")
#  stock               :integer          default(0)
#  unit_price_cents    :integer          default(0)
#  unit_price_currency :integer          default("USD")
#  category_id         :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
FactoryBot.define do
  factory :product do
    title { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    stock { Faker::Number.between(from: 0, to: 100) }
    unit_price_cents { Faker::Commerce.price * 100 }
    unit_price_currency { %i[USD EUR BTC].sample }
    state { Product.states.values.sample }
    category
  end
end
