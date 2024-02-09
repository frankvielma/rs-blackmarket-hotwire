# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RegistrationsController do
  before do
    set_devise_mapping
  end

  describe '#create' do
    let(:user_attributes) { attributes_for(:user, password: '12345678', password_confirmation: '12345678') }

    context 'when valid user attributes are provided' do
      it 'creates a new user' do
        expect {
          post :create, params: { user: user_attributes }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the sign in page' do
        post :create, params: { user: user_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when invalid user attributes are provided' do
      let(:user_attributes) { attributes_for(:user, password: '12345', password_confirmation: '12345678') }

      it 'does not create a new user' do
        expect {
          post :create, params: { user: user_attributes }
        }.not_to change(User, :count)
      end

      it 'renders the same form' do
        post :create, params: { user: user_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
