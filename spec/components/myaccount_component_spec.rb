# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyaccountComponent, type: :component do
  describe 'my account component' do
    before do
      render_inline(described_class.new)
    end

    it 'renders the my account component title' do
      expect(page).to have_xpath('//div[@id="dropdownButton"]')
      menu_title = page.find_xpath('//div[@id="dropdownButton"]').first.text.strip
      expect(menu_title).to eq('My Account')
    end

    it 'renders the my account component log out option' do
      expect(page).to have_xpath('//div[@id="dropdownMenu"]')
      menu_title = page.find_xpath('//div[@id="dropdownMenu"]').first.text.strip
      expect(menu_title).to eq('Sign out')
    end
  end
end
