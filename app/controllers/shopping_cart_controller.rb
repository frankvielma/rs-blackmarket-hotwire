# frozen_string_literal: true

class ShoppingCartController < ApplicationController
  include Devise::Controllers::Helpers
  before_action :authenticate_user!

  def index
    cart_items = ShoppingCart.includes(:product).where(user_id: current_user)
    total = cart_items.sum { |item|
      item.product.unit_price_cents * item.line_items.first.quantity
    } / 100.0

    render_cart(cart_items, total)
  end

  def update
    shopping_cart = ShoppingCart.find_by(product_id: params[:id], user_id: current_user)
    line_item = shopping_cart.line_items.first
    quantity = line_item.quantity
    if params['operation'] == 'add'
      line_item.update!(quantity: quantity + 1)
    else
      line_item.update!(quantity: quantity - 1)
    end
  end

  def destroy
    ShoppingCart.find_by(product_id: params[:id], user_id: current_user).destroy
  end

  private

  def render_cart(cart_items, total)
    partial = cart_items.present? ? 'shopping_cart/search_results' : 'shopping_cart/empty'
    render turbo_stream: [
      turbo_stream.update('toggle-shopping-product', ProductButtonComponent.new),
      turbo_stream.update('main', partial:, locals: { cart_items:, total: })
    ]
  end
end
