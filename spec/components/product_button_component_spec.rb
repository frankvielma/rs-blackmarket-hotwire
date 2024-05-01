# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductButtonComponent, type: :component do
  it 'renders the button' do
    render_inline(described_class.new)
    expect(page).to have_text('Products')
    expect(page).to have_button
  end
end
