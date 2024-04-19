# frozen_string_literal: true

class QuantityUpdaterComponent < ViewComponent::Base
  def initialize(product:)
    @product = product
  end
end
