# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ErrorsController do
  describe 'GET #not_found' do
    it 'returns a 404 Not Found status code' do
      get :not_found

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET #internal_server_error' do
    it 'returns a 500 Internal Server Error status code' do
      get :internal_server_error

      expect(response).to have_http_status(:internal_server_error)
    end
  end
end
