# frozen_string_literal: true

class UsersController < ApplicationController
  layout 'user'

  def index; end

  def new
    @user = User.new
  end
end
