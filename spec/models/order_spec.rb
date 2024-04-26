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
require 'rails_helper'

RSpec.describe Order do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:total_price_cents) }
    it { is_expected.to validate_numericality_of(:total_price_cents).is_greater_than(0) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:shipping_addresses).dependent(:destroy) }
  end

  describe 'creation' do
    context 'with valid attributes' do
      let(:user) { create(:user, password: 'password', password_confirmation: 'password') }

      it 'creates a valid order' do
        order = described_class.new(user_id: user.id, total_price_cents: 1000)
        expect(order).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'is invalid without a user' do
        order = described_class.new(total_price_cents: 1000)
        expect(order).not_to be_valid
        expect(order.errors[:user_id]).to include("can't be blank")
      end

      it 'is invalid with a non-positive total price' do
        order = described_class.new(user_id: 1, total_price_cents: 0)
        expect(order).not_to be_valid
        expect(order.errors[:total_price_cents]).to include('must be greater than 0')
      end
    end
  end

  describe 'dependent destroy association' do
    context 'when order is destroyed' do
      let(:user) { create(:user, password: 'password', password_confirmation: 'password') }
      let!(:order) { create(:order, user_id: user.id, total_price_cents: 1000) }
      let!(:shipping_address) { create(:shipping_address, order:) }

      it 'destroys associated shipping addresses' do
        expect { order.destroy }.to change(ShippingAddress, :count).by(-1)
      end
    end
  end
end
