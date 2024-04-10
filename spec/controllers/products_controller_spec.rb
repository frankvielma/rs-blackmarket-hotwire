# frozen_string_literal: true

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
end
