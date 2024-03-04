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

  # Enum validation
  describe 'unit_price_currency enum' do
    it { is_expected.to define_enum_for(:unit_price_currency).with_values(USD: 0, EUR: 1, BTC: 2) }
  end

  describe 'state enum' do
    it { is_expected.to define_enum_for(:state).with_values(used: 0, not_used: 1, refurbished: 2) }
  end

  # Image attachment
  describe 'image attachment' do
    it { is_expected.to have_one_attached(:image) }
  end
end
