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
require 'rails_helper'

RSpec.describe Product do
  # Validations
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:unit_price_cents) }
    it { is_expected.to validate_presence_of(:unit_price_currency) }
  end

  # Associations
  describe 'associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_one_attached(:image) }
  end

  # Enums
  describe 'enums' do
    it { is_expected.to define_enum_for(:unit_price_currency).with_values(USD: 0, EUR: 1, BTC: 2) }
    it { is_expected.to define_enum_for(:state).with_values(used: 0, not_used: 1, refurbished: 2) }
  end

  it 'does not allow negative stock' do
    product = build(:product, stock: -5)
    expect(product).not_to be_valid
    expect(product.errors[:stock]).to include('must be greater than or equal to 0')
  end

  it 'does not allow negative unit price cents' do
    product = build(:product, unit_price_cents: -100)
    expect(product).not_to be_valid
    expect(product.errors[:unit_price_cents]).to include('must be greater than or equal to 0')
  end
end
