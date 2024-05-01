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
require 'rails_helper'

RSpec.describe ShippingAddress do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:line1) }
    it { is_expected.to validate_presence_of(:postal_code) }
    it { is_expected.to validate_length_of(:postal_code).is_equal_to(5) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:order) }
  end

  describe 'creation' do
    context 'with valid attributes' do
      it 'creates a valid shipping address' do
        user = create(:user, password: 'password', password_confirmation: 'password')
        order = create(:order, user_id: user.id, total_price_cents: 1000)
        address = described_class.new(
          country: 'USA',
          city: 'Miami',
          state: 'FL',
          line1: '123 Main Street',
          postal_code: '12345',
          order_id: order.id
        )
        expect(address).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'is invalid without a country' do
        address = described_class.new(city: 'USA', state: 'Florida', line1: '123 Main Street', postal_code: '12345')
        expect(address).not_to be_valid
        expect(address.errors[:country]).to include("can't be blank")
      end

      it 'is invalid with an invalid postal code length' do
        address = described_class.new(
          country: 'USA',
          city: 'Miami',
          state: 'FL',
          line1: '123 Main Street',
          postal_code: '1234'
        )
        expect(address).not_to be_valid
        expect(address.errors[:postal_code]).to include('is the wrong length (should be 5 characters)')
      end
    end
  end
end
