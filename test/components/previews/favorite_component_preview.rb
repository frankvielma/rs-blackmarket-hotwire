# frozen_string_literal: true

class FavoriteComponentPreview < ViewComponent::Preview
  def default
    render(FavoriteComponent.new(product_id: 1))
  end
end
