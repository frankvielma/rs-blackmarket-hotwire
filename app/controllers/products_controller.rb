# frozen_string_literal: true

class ProductsController < ApplicationController
  include Devise::Controllers::Helpers
  before_action :authenticate_user!

  # def index
  #   query = params[:query]
  #   state = params[:state]
  #   products = query.present? || state.present? ? Product.search_products(query, state) : Product.all
  #   @pagy, @products = pagy(products, items: 5) if products.present?

  #   return if query.blank?

  #   partial = if @products.present?
  #               'products/search_results'
  #             else
  #               'products/empty'
  #             end

  #   render turbo_stream: turbo_stream.update('main', partial:, locals: { products:, query: })
  # end

  def index
    query = params[:query]
    state = params[:state]
    products = search_products(query, state)
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

  private

  def search_products(query, state)
    query.present? || state.present? ? Product.search_products(query, state) : Product.all
  end

  def paginate_products(products)
    @pagy, @products = pagy(products, items: 5) if products.present?
  end

  def render_search_results_partial(products, query)
    partial = products.present? ? 'products/search_results' : 'products/empty'
    render turbo_stream: turbo_stream.update('main', partial:, locals: { products:, query: })
  end
end
