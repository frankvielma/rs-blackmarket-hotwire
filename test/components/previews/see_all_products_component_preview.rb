# frozen_string_literal: true

class SeeAllProductsComponentPreview < ViewComponent::Preview
  def default
    render(SeeAllProductsComponent.new)
  end
end
