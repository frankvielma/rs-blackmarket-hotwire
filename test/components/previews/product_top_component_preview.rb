# frozen_string_literal: true

class ProductTopComponentPreview < ViewComponent::Preview
  def default
    render(ProductTopComponent.new)
  end
end
