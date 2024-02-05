# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DiscountComponent, type: :component do
  describe 'Discount component' do
    before do
      render_inline(described_class.new)
    end

    it 'renders the discount component' do
      expect(page).to have_xpath('//div[@id="discount"]')
    end

    it 'renders text at the right box' do
      text = page.find_xpath('//div[@id="discount"]/h1/div').text
      expect(text).to eq('Check our new and restored furnitureShop today and receive a special 10% discount!')
    end
  end
end
