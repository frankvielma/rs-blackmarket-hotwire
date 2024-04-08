# frozen_string_literal: true

class SearchBarComponent < ViewComponent::Base
  def initialize(placeholder:, size:)
    @placeholder = placeholder
    @size = size
  end
end
