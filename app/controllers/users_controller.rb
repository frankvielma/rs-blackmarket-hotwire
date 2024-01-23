# frozen_string_literal: true

class UsersController < ApplicationController
  def sign_in
    user = User.find_by(email: params[:email])
    access_token = params[:access_token]
    client = params[:client]

    if user.nil?
      user = create_user(params)
    else
      user.update!(tokens: access_token, client:)
    end

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

  def create_user(params)
    user = User.new(email: params[:email])
    user.tokens = params[:access_token]
    user.client = params[:client]
    user.save!
    user
  end
end
