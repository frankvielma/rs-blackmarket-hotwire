# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShoppingCartController do
  let(:user) { create(:user, password: 'password', password_confirmation: 'password') }
  let(:product) { create(:product) }
  let!(:cart_item) { create(:shopping_cart, user:, product:) }
  let!(:line_item) { create(:line_item, product:, shopping_cart: cart_item) }

  before do
    product.image.attach(fixture_file_upload('image.jpg', 'image/jpeg'))
    sign_in user
  end

  describe 'GET #index' do
    context 'when user has cart items' do
      it 'returns success status' do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the login page' do
        sign_out(user)
        get :index

        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'PUT #update' do
    context "when operation is 'add'" do
      it 'increases the quantity of the line item' do
        initial_quantity = cart_item.line_items.first.quantity
        put :update, params: { id: product.id, operation: 'add' }
        expect(cart_item.reload.line_items.first.quantity).to eq(initial_quantity + 1)
      end

      it 'returns a successful response' do
        put :update, params: { id: product.id, operation: 'add' }
        expect(response).to be_successful
      end
    end

    context "when operation is 'subtract'" do
      before do
        line_item.quantity = 2
        line_item.save!
      end

      it 'decreases the quantity of the line item' do
        put :update, params: { id: product.id, operation: 'subtract' }
        expect(cart_item.reload.line_items.first.quantity).to eq(1)
      end

      it 'removes the line item if quantity reaches 0' do
        put :update, params: { id: product.id, operation: 'subtract' }
        expect(cart_item.reload.line_items.count).to eq(1)
      end

      it 'returns a successful response' do
        put :update, params: { id: product.id, operation: 'subtract' }
        expect(response).to be_successful
      end
    end

    it 'requires authentication' do
      sign_out user
      put :update, params: { id: product.id, operation: 'add' }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'DELETE #destroy' do
    it 'removes the shopping cart item' do
      delete :destroy, params: { id: product.id }
      expect(ShoppingCart.where(product:, user:).count).to eq(0)
    end

    it 'returns a successful response' do
      delete :destroy, params: { id: product.id }
      expect(response).to be_successful
    end

    it 'requires authentication' do
      sign_out user
      delete :destroy, params: { id: product.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
