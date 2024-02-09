# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeaderComponent, type: :component do
  describe 'Header component' do
    before do
      render_inline(described_class.new)
    end

    it 'renders the logo compoent' do
      expect(page).to have_xpath('//div[@id="logo"]')
    end

    it 'render the search component' do
      expect(page).to have_xpath('//div[@id="search"]')
    end

    it 'render the my account component' do
      expect(page).to have_xpath('//div[@id="myAccount"]')
    end

    it 'render the shopping cart component' do
      expect(page).to have_xpath('//div[@id="shoppingCart"]')
    end
  end
end
