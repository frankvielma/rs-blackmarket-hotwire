# frozen_string_literal: true

class StateComponentPreview < ViewComponent::Preview
  def not_used_state
    render(StateComponent.new(state: 'not_used'))
  end

  def used_state
    render(StateComponent.new(state: 'used'))
  end

  def restore_state
    render(StateComponent.new(state: 'restored'))
  end
end
