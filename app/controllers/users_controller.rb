# frozen_string_literal: true

class UsersController < ApplicationController
  # This function signs in the user by finding the user with the given email,
  # updating the user's access token and client, and then rendering a JSON
  # response indicating success.
  def sign_in
    user = User.find_by(email: params[:email])
    access_token = params[:access_token]
    client = params[:client]

    user.update!(tokens: access_token, client:)

    session[:user_id] = user.id
    render json: { success: true }
  end

  # Creates a new user with the provided email, access token, and client parameters and saves it to the database.
  # Returns a JSON response indicating success.
  def sign_up
    user = User.new(email: params[:email])
    user.tokens = params[:access_token]
    user.client = params[:client]
    user.save!

    render json: { success: true }
  end

  def sign_out
    session.delete(:user_id)
    redirect_to login_path
  end
end
