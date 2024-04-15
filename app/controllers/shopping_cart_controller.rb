# frozen_string_literal: true

class ShoppingCartController < ApplicationController
  def index
    @cart_items = ShoppingCart.all
  end
end
