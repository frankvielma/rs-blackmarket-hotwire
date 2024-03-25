# frozen_string_literal: true

class ProductsController < ApplicationController
  include Devise::Controllers::Helpers

  def index; end

  def favorite
    @product = Product.find(params[:id])
    favorite_products = @product.favorite_products

    if favorite_products.any?
      favorite_products.destroy_all
    else
      favorite_products.create!(user: current_user)
    end

    render json: {}
  end
end
