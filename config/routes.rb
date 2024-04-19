# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }
  devise_for :admin_users
  authenticate :admin_user do
    mount Motor::Admin => '/admin'
  end

  # mount Motor::Admin => '/motor_admin'

  get 'errors/not_found'
  get 'errors/internal_server_error'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root 'home#index'

  get 'dashboard' => 'dashboard#index', as: :dashboard

  resources :products do
    get 'index', on: :collection
    post 'favorite', on: :member
    post 'shopping_carts', on: :member
  end

  resources :shopping_cart do
    get 'index', on: :collection
    delete 'destroy', on: :member
    put 'update', on: :member
  end

  get 'categories/search' => 'categories#search', as: :search

  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  mount Lookbook::Engine, at: '/lookbook' if Rails.env.development?
end
