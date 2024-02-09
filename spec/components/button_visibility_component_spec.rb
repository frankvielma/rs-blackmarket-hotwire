# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ButtonVisibilityComponent, type: :component do
  it 'renders the button' do
    render_inline(described_class.new)
    expect(page).to have_button
  end

  it 'renders the visibility icon' do
    render_inline(described_class.new)
    expect(page).to have_css('.visibility_on')
  end
end
