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
class Product < ApplicationRecord
  belongs_to :category

  enum unit_price_currency: { USD: 0, EUR: 1, BTC: 2 }
  enum state: { used: 0, not_used: 1, refurbished: 2 }

  validates :title, :description, :unit_price_cents, :unit_price_currency, presence: true
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
  validates :unit_price_cents, numericality: { greater_than_or_equal_to: 0 }

  has_one_attached :image
end