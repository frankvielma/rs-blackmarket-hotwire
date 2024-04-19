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
  enum unit_price_currency: { USD: 0, EUR: 1, BTC: 2 }
  enum state: { used: 0, is_new: 1, restored: 2 }

  validates :title, :description, :unit_price_cents, :unit_price_currency, presence: true
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
  validates :unit_price_cents, numericality: { greater_than_or_equal_to: 0 }

  has_one_attached :image
  has_many :favorite_products, dependent: :destroy
  has_many :shopping_carts, dependent: :destroy
  has_many :line_items, dependent: :destroy
  belongs_to :category

  default_scope -> { order(:id) }
  scope :featured, -> { order('random()').limit(4) }

  def self.search_products(params)
    query = params[:query]
    state = params[:state]
    categories_id = params[:categories_id]

    return where(category_id: categories_id) if categories_id.present?

    state_id = Product.states[state]
    if state_id.present?
      where('(title ILIKE ? OR description ILIKE ?) AND state = ?', "%#{query}%", "%#{query}%", state_id)
    else
      where('title ILIKE ? OR description ILIKE ?', "%#{query}%", "%#{query}%")
    end
  end

  def price
    unit_price_cents / 100.0
  end
end
