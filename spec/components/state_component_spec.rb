# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StateComponent, type: :component do
  describe 'with different state values' do
    let(:states) { %w[restored is_new used] }

    it 'renders the correct background color for each state' do
      states.each do |state|
        rendered = render_inline(described_class.new(state:))
        expected_color = 'bg-[' + color(state) + ']'
        expect(rendered).to have_css('div', class: expected_color)
      end
    end

    it "renders the state text except for 'is_new'" do
      states.each do |state|
        expected_text = state == 'is_new' ? 'new' : state
        rendered = render_inline(described_class.new(state:))
        expect(rendered).to have_text(expected_text)
      end
    end
  end

  def color(state)
    {
      'restored' => '#559F21',
      'is_new' => '#2751B9',
      'used' => '#D42F1A'
    }[state]
  end
end
