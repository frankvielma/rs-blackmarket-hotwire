# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoryComponent, type: :component do
  describe 'Category component' do
    it 'renders the button' do
      render_inline(described_class.new(type: 'mobile'))
      expect(page).to have_button
    end

    it 'renders id mobile' do
      render_inline(described_class.new(type: 'mobile'))
      expect(page).to have_xpath('//div[@id="listMobile"]')
    end

    it 'renders id desktop' do
      render_inline(described_class.new(type: 'desktop'))
      expect(page).to have_xpath('//div[@id="listDesktop"]')
    end
  end
end
