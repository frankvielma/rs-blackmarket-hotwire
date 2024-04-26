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
class Order < ApplicationRecord
  validates :user_id, :total_price_cents, presence: true
  validates :total_price_cents, numericality: { greater_than: 0 }

  has_many :shipping_addresses, dependent: :destroy
end
