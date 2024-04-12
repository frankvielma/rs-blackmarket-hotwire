# frozen_string_literal: true

class ProductsController < ApplicationController
  include Devise::Controllers::Helpers
  before_action :authenticate_user!

  def index
    query = params[:query]
    products = search_products(params)
    paginate_products(products)
    return if query.blank?

    render_search_results_partial(products, query)
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

  def shopping_carts
    @product = Product.find(params[:id])
    shopping_carts_products = @product.shopping_carts

    if shopping_carts_products.any?
      shopping_carts_products.destroy_all
    else
      shopping_carts_products.create!(user: current_user)
    end

    render json: { id: @product.id }
  end

  private

  def search_products(params)
    query = params[:query]
    state = params[:state]
    categories_id = params[:categories_id]
    query.present? || state.present? || categories_id.present? ? Product.search_products(params) : Product.all
  end

  def paginate_products(products)
    @pagy, @products = pagy(products, items: 5) if products.present?
  end

  def render_search_results_partial(products, query)
    partial = products.present? ? 'products/search_results' : 'products/empty'
    render turbo_stream: turbo_stream.update('main', partial:, locals: { products:, query: })
  end
end
