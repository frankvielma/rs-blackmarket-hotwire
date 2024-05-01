# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FavoriteComponent, type: :component do
  let(:user) { create(:user, password: 'password', password_confirmation: 'password') }
  let(:product) { create(:product) }

  before do
    sign_in user
  end

  describe 'when product is not favorited' do
    before do
      allow(FavoriteProduct).to receive(:where).and_return([])
    end

    it 'renders favorite_off class' do
      rendered = render_inline(described_class.new(product_id: product.id))

      expect(rendered).to have_xpath("//img[1][contains(@class, '')]")
      expect(rendered).to have_xpath("//img[2][contains(@class, 'hidden')]")
    end
  end

  describe 'when product is favorited' do
    before do
      allow(FavoriteProduct).to receive(:where).and_return([instance_double('FavoriteProduct')]) # Favorite exists
    end

    it 'renders favorite_on class' do
      rendered = render_inline(described_class.new(product_id: product.id))

      expect(rendered).to have_xpath("//img[1][contains(@class, 'hidden')]")
      expect(rendered).to have_xpath("//img[2][contains(@class, '')]")
    end
  end
end
