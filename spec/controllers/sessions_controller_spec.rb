# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController do
  before do
    set_devise_mapping
  end

  describe '#create' do
    context 'when valid user attributes are provided' do
      let(:user_attributes) { attributes_for(:user, password: '12345678', password_confirmation: '12345678') }

      it 'signs in a user' do
        user = create(:user, user_attributes)
        post :create, params: { user: user_attributes }
        expect(response).to redirect_to(dashboard_path)
        expect(controller.current_user).to eq(user)
      end
    end

    context 'when invalid user attributes are provided' do
      let(:user_attributes) { attributes_for(:user, password: '12345678', password_confirmation: '12345678') }

      it 'does not sign in a user with invalid credentials' do
        create(:user, user_attributes)
        post :create, params: { user: attributes_for(:user, password: '128', password_confirmation: '12345678') }
        expect(controller.current_user).to be_nil
      end

      it 'renders the same form' do
        post :create, params: { user: user_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#destroy' do
    let(:user_attributes) { attributes_for(:user, password: '12345678', password_confirmation: '12345678') }

    it 'logs out the user and redirects to the root path' do
      create(:user, user_attributes)
      post :create, params: { user: user_attributes }

      delete :destroy

      expect(response).to redirect_to(root_path)
      expect(controller.current_user).to be_nil
    end
  end
end
