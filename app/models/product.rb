# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                  :bigint           not null, primary key
#  title               :string
#  description         :text
#  state               :integer
#  stock               :integer
#  unit_price_cents    :integer
#  unit_price_currency :integer          default("USD")
#  category_id         :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Product < ApplicationRecord
  enum unit_price_currency: { USD: 0, EUR: 1, BTC: 2 }

  validates :title, :description, :unit_price_cents, :unit_price_currency, presence: true

  has_one_attached :image
end
