# frozen_string_literal: true

class ProductButtonComponentPreview < ViewComponent::Preview
  def default
    render(ProductButtonComponent.new)
  end
end
