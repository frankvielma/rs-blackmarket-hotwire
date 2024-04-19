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

RSpec.describe ProductsController do
  describe 'GET #index' do
    context 'when user is not authenticated' do
      it 'redirects to login page' do
        get :index

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path) # Replace with your login path
      end
    end
  end

  describe 'POST #favorite' do
    context 'when user is authenticated' do
      let(:user) { create(:user, password: 'password', password_confirmation: 'password') }
      let(:product) { create(:product) }

      before do
        sign_in user
      end

      it 'adds product to favorites if not already favorited' do
        post :favorite, params: { id: product.id }

        expect(response).to have_http_status(:ok)
        expect(product.favorite_products.find_by(user:)).to be_present
      end

      it 'removes product from favorites if already favorited' do
        product.favorite_products.create!(user:)
        post :favorite, params: { id: product.id }

        expect(response).to have_http_status(:ok)
        expect(product.favorite_products.find_by(user:)).to be_nil
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login page' do
        product = create(:product)
        post :favorite, params: { id: product.id }

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path) # Replace with your login path
      end
    end
  end

  describe 'POST #shopping_carts' do
    let(:current_user) { create(:user, password: 'password', password_confirmation: 'password') }
    let(:product) { create(:product) }

    before { sign_in(current_user) }

    context 'when product exists' do
      it 'creates a new ShoppingCart and LineItem for the current user' do
        expect { post :shopping_carts, params: { id: product.id } }.to change(ShoppingCart, :count).by(1)
        expect(ShoppingCart.last.user).to eq(current_user)
        expect(ShoppingCart.last.line_items.last.product).to eq(product)
        expect(ShoppingCart.last.line_items.last.quantity).to eq(1)
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['id']).to eq(product.id.to_s)
      end
    end
  end
end
