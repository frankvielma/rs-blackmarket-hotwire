# frozen_string_literal: true

class StateComponent < ViewComponent::Base
  def initialize(state:)
    @state = state
  end

  def color(state)
    {
      'restored' => 'bg-[#559F21]',
      'is_new' => 'bg-[#2751B9]',
      'used' => 'bg-[#D42F1A]'
    }[state]
  end

  def text(state)
    return state unless state == 'is_new'

    'new'
  end
end
