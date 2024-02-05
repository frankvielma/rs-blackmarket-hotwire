# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShipmentComponent, type: :component do
  describe 'Shipment component' do
    before do
      render_inline(described_class.new)
    end

    it 'renders the shipment component' do
      expect(page).to have_xpath('//div[@id="shipment"]')
    end

    it 'renders text at the left box' do
      text = page.find_xpath('//div[@id="shipment"]/h1/div').text
      expect(text).to eq('We upgraded our shipments many levels up.Now Powered by FedEx')
    end
  end
end
