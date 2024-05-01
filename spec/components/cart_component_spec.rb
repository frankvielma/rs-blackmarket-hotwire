# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartComponent, type: :component do
  let(:user) { create(:user, password: 'password', password_confirmation: 'password') }
  let(:product) { create(:product) }
  let!(:cart_item) { create(:shopping_cart, user:, product:) }
  let(:line_item) { create(:line_item, product:, shopping_cart: cart_item) }

  before do
    product.image.attach(fixture_file_upload('image.jpg', 'image/jpeg'))
    line_item.quantity = 2
    sign_in user
  end

  it 'renders the product name' do
    rendered = render_inline(described_class.new(product:))

    expect(rendered).to have_text product.title.truncate(10)
  end
end
