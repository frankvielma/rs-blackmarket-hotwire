# frozen_string_literal: true

class StateComponentPreview < ViewComponent::Preview
  def new_state
    render(StateComponent.new(state: 'is_new'))
  end

  def used_state
    render(StateComponent.new(state: 'used'))
  end

  def restore_state
    render(StateComponent.new(state: 'restored'))
  end
end
