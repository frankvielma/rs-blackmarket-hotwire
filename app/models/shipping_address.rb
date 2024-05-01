# frozen_string_literal: true

# == Schema Information
#
# Table name: shipping_addresses
#
#  id          :bigint           not null, primary key
#  country     :string
#  city        :string
#  state       :string
#  line1       :string
#  line2       :string
#  postal_code :string
#  order_id    :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class ShippingAddress < ApplicationRecord
  validates :country, :city, :state, :line1, :postal_code, presence: true
  validates :postal_code, length: { is: 5 }

  belongs_to :order
end
