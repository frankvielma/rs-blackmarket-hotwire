# frozen_string_literal: true

class CategoryComponentPreview < ViewComponent::Preview
  def default
    render(CategoryComponent.new(type: 'desktop'))
  end
end
