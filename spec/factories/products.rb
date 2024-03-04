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
    title { 'MyString' }
    description { 'MyText' }
    state { 1 }
    stock { 1 }
    unit_price_cents { 1 }
    unit_price_currency { 'MyString' }
    category_id { 1 }
  end
end
