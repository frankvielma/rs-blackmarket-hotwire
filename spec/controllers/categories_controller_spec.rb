# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController do
  describe 'GET #search' do
    context 'when user is authenticated' do
      let(:user) { create(:user, password: 'password', password_confirmation: 'password') }

      before do
        sign_in user
      end

      it 'returns success (200) for HTML format' do
        params = { name: 'Search Term' }
        get(:search, params:)

        expect(response).to have_http_status(:ok)
      end

      it 'returns success (200) with JSON data' do
        params = { name: 'Search Term', format: :json }
        get(:search, params:)

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to include('application/json')
        expect(response.parsed_body).to be_a(Array) # Check for array of categories
      end

      it 'searches categories by name (ilike)' do
        # Create some categories for testing
        create(:category, name: 'Category 1')
        create(:category, name: 'Category 2')
        create(:category, name: 'Matching Category')

        params = { name: 'Matching' }
        get(:search, params:)

        expect(controller.instance_variable_get(:@categories).count).to eq(1)
        expect(controller.instance_variable_get(:@categories).first.name).to eq('Matching Category')
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login page' do
        params = { name: 'Search Term' }
        get(:search, params:)

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path) # Replace with your login path
      end
    end
  end
end
