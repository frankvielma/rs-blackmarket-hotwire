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
require 'rails_helper'

RSpec.describe ShoppingCart do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:product) }
  end
end
