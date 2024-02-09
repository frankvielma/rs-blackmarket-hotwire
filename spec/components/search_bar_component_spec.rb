# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchBarComponent, type: :component do
  describe 'render search bar' do
    let(:rendered_component) { render_inline(described_class.new) }

    it 'renders the search bar component' do
      expect(rendered_component).to have_xpath('//input[@type="text"][@placeholder="Search for products"]')
    end
  end
end
