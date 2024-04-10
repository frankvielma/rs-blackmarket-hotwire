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
  describe 'associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_one_attached(:image) }
    it { is_expected.to have_many(:favorite_products).dependent(:destroy) }
    it { is_expected.to have_many(:shopping_carts).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:unit_price_cents) }
    it { is_expected.to validate_presence_of(:unit_price_currency) }
    it { is_expected.to validate_numericality_of(:stock).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:unit_price_cents).is_greater_than_or_equal_to(0) }
  end

  describe 'enums' do
    it 'defines unit_price_currency enum' do
      expect(described_class.unit_price_currencies.keys).to eq(%w[USD EUR BTC])
    end

    it 'defines state enum' do
      expect(described_class.states.keys).to eq(%w[used is_new restored])
    end
  end

  describe 'default_scope' do
    it 'orders products by id' do
      products = create_list(:product, 3)
      expect(described_class.all).to eq(products)
    end
  end

  describe 'featured scope' do
    it 'returns 4 random products' do
      create_list(:product, 10)
      expect(described_class.featured.count).to eq(4)
    end
  end

  describe 'search_products' do
    let(:cool_gadget_product) do
      create(:product, title: 'Cool Gadget', description: 'A very cool gadget', state: :used)
    end
    let(:awesome_toy_cool) { create(:product, title: 'Awesome Toy cool', state: :is_new) }

    context 'with categories_id' do
      it 'returns products for the given category' do
        category = create(:category)
        cool_gadget_product.update!(category:)
        expect(described_class.search_products(categories_id: category.id)).to eq([cool_gadget_product])
      end
    end

    context 'with query and state' do
      it 'returns products matching query and state' do
        expect(described_class.search_products(query: 'cool', state: 'used')).to eq([cool_gadget_product])
      end
    end

    context 'with query only' do
      it 'returns products matching query' do
        expect(described_class.search_products(query: 'cool')).to include(cool_gadget_product, awesome_toy_cool)
      end
    end

    context 'with no params' do
      it 'returns all products' do
        expect(described_class.search_products({})).to eq([cool_gadget_product, awesome_toy_cool])
      end
    end
  end

  describe 'price' do
    let(:product) { create(:product, unit_price_cents: 1234) }

    it 'returns formatted price' do
      expect(product.price).to eq(12.34)
    end
  end
end
