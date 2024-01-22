# frozen_string_literal: true

class DashboardController < ApplicationController
  layout 'dashboard'

  def index
    return if session[:user_id].present?

    redirect_to login_path
  end
end
