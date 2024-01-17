# frozen_string_literal: true

class UsersController < ApplicationController
  layout 'user'

  def login; end

  def new
    @user = User.new
  end
end
