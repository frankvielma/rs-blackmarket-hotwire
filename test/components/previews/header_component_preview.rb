# frozen_string_literal: true

class HeaderComponentPreview < ViewComponent::Preview
  def default
    render(HeaderComponent.new(featured: true))
  end
end
