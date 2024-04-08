# frozen_string_literal: true

class ConditionComponentPreview < ViewComponent::Preview
  def default
    render(ConditionComponent.new)
  end
end
