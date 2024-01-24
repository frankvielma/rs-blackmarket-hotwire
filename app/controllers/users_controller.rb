# frozen_string_literal: true

class UsersController < ApplicationController
  def sign_in
    user = User.find_by(email: params[:email])
    user = update_create_user(user, params)
    session[:user_id] = user.id
    render json: { success: true }
  end

  def sign_up
    create_user(params)
    render json: { success: true }
  end

  def sign_out
    session.delete(:user_id)
    redirect_to login_path
  end

  private

  def update_create_user(user, params)
    user.nil? ? create_user(params) : update_user(user, params)
    user
  end

  def update_user(user, params)
    user.update!(tokens: params[:access_token], client: params[:client])
    user
  end

  def create_user(params)
    user = User.new(email: params[:email])
    user.tokens = params[:access_token]
    user.client = params[:client]
    user.save!
    user
  end
end
