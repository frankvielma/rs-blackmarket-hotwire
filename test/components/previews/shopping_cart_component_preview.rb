# frozen_string_literal: true

class ShoppingCartComponentPreview < ViewComponent::Preview
  def default
    render(ShoppingCartComponent.new)
  end
end
