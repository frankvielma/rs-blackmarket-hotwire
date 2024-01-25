# frozen_string_literal: true

class SocialComponentPreview < ViewComponent::Preview
  def default
    render(SocialComponent.new)
  end
end
