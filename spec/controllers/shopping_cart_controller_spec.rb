# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShoppingCartController do
  describe 'GET #index' do
    context 'when user is not authenticated' do
      it 'redirects to the login page' do
        get :index

        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(:found)
      end
    end
  end
end
