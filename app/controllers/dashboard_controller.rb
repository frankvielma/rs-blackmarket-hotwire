# frozen_string_literal: true

class DashboardController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_user!

  def index; end
end
