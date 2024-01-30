# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShoppingCartComponent, type: :component do
  describe 'render shopping cart' do
    let(:rendered_component) { render_inline(described_class.new) }

    it 'renders the shopping cart component' do
      button_text = rendered_component.elements.first.children[1].text.strip
      expect(button_text).to eq('Shopping Cart')
    end
  end
end
