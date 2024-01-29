# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get 'errors/not_found'
  get 'errors/internal_server_error'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root 'home#index'

  # get 'login' => 'users#login'
  # post 'sign_in' => 'users#sign_in'
  # get 'singup' => 'users#new'
  # post 'sign_up' => 'users#sign_up'
  # get 'sign_out' => 'users#sign_out'
  get 'dashboard' => 'dashboard#index', as: :dashboard

  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  mount Lookbook::Engine, at: '/lookbook' if Rails.env.development?
end
