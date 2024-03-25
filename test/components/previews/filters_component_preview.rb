# frozen_string_literal: true

class FiltersComponentPreview < ViewComponent::Preview
  def default
    render(FiltersComponent.new)
  end
end
