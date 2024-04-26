# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                   :bigint           not null, primary key
#  user_id              :bigint
#  total_price_cents    :integer
#  total_price_currency :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
FactoryBot.define do
  factory :order do
    total_price_cents { 1 }
    total_price_currency { 'USD' }
  end
end
