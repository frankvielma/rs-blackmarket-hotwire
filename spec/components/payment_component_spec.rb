# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentComponent, type: :component do
  describe 'Payment component' do
    before do
      render_inline(described_class.new)
    end

    it 'renders the payment component' do
      expect(page).to have_xpath('//div[@id="payment"]')
    end

    it 'renders text under icons' do
      text = page.find_xpath('//div[@id="payment"]/div/div/div').text.delete("\n").split.join(' ')
      expect(text).to eq('Credit Paypal Crypto')
    end
  end
end
