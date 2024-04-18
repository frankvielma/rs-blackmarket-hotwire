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
class LineItem < ApplicationRecord
  belongs_to :shopping_cart
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
