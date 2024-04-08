# frozen_string_literal: true

class SearchBarComponentPreview < ViewComponent::Preview
  def default
    render(SearchBarComponent.new(placeholder: 'Search for products', size: 'desktop'))
  end
end
