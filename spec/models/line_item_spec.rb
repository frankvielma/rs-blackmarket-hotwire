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
require 'rails_helper'

RSpec.describe LineItem do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:shopping_cart) }
    it { is_expected.to belong_to(:product) }
  end
end
