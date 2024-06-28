# frozen_string_literal: true

class ProductsController < ApplicationController
  include Devise::Controllers::Helpers
  before_action :authenticate_user!

  def index
    @products = search_products(params)
    @pagy, @products = paginate_products(@products)
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
    product_id = params[:id]
    update_shopping_cart(product_id)

    render json: { id: product_id }
  end

  private

  def update_shopping_cart(product_id)
    return if product_not_found?(product_id)

    shopping_carts_products = ShoppingCart.where(product_id:)

    shopping_carts_products.any? ? shopping_carts_products.destroy_all : create_shopping_cart_and_line_item(product_id)
  end

  def product_not_found?(product_id)
    Product.find_by(id: product_id).nil?
  end

  def create_shopping_cart_and_line_item(product_id)
    ShoppingCart.transaction do
      shopping_cart = ShoppingCart.create!(user: current_user, product_id:)
      shopping_cart.line_items.create!(quantity: 1, product_id:)
    end
  end

  def search_products(params)
    query = params[:query]
    state = params[:state]
    categories_id = params[:categories_id]
    query.present? || state.present? || categories_id.present? ? Product.search_products(params) : Product.all
  end

  def paginate_products(products)
    @pagy, @products = pagy(products, items: 5)
  end
end
