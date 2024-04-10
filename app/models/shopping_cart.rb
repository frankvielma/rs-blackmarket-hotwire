# frozen_string_literal: true

# == Schema Information
#
# Table name: shopping_carts
#
#  id         :bigint           not null, primary key
#  user_id    :integer
#  product_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShoppingCart < ApplicationRecord
  belongs_to :user
  belongs_to :product
end
