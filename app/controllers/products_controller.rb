# frozen_string_literal: true

class ProductsController < ApplicationController
  include Devise::Controllers::Helpers
  before_action :authenticate_user!

  def index
    query = params[:query]
    products = query.present? ? Product.search_products(query) : Product.all
    @pagy, @products = pagy(products, items: 5) if products.present?

    return if query.blank?

    partial = if @products.present?
                'products/search_results'
              else
                'products/empty'
              end

    render turbo_stream: turbo_stream.update('main', partial:, locals: { products: })
  end

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
