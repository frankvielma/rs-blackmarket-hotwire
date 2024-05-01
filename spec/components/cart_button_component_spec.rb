# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartButtonComponent, type: :component do
  let(:user) { create(:user, password: 'password', password_confirmation: 'password') }
  let(:product) { create(:product) }

  before do
    sign_in user
  end

  it 'renders the button' do
    render_inline(described_class.new(product:))
    expect(page).to have_button
  end

  describe 'when product is not in the cart' do
    it 'renders button with border class' do
      allow(ShoppingCart).to receive(:where).and_return([])

      rendered = render_inline(described_class.new(product:))

      expect(rendered).to have_button(class: 'text-black bg-white border')
    end
  end

  describe 'when product is in the cart' do
    it 'renders button with white text and black background class' do
      allow(ShoppingCart).to receive(:where).and_return([instance_double('ShoppingCartItem')])

      rendered = render_inline(described_class.new(product:))

      expect(rendered).to have_button(class: 'text-white bg-black')
    end
  end
end
