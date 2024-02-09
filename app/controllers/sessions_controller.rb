# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(_resource)
    dashboard_path
  end
end
