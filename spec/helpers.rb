# frozen_string_literal: true

module Helpers
  # Helper method to parse a response
  #
  # @return [Hash]
  def json
    JSON.parse(response.body).with_indifferent_access
  end

  def auth_headers
    user.create_new_auth_token
  end

  def set_devise_mapping
    request.env['devise.mapping'] = Devise.mappings[:user]
  end
end
