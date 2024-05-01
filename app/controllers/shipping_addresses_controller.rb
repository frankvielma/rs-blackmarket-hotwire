# frozen_string_literal: true

class ShippingAddressesController < ApplicationController
  def new
    @shipping_address = ShippingAddress.new
  end
end
