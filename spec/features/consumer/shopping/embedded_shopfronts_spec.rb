require 'spec_helper'

feature "Using embedded shopfront functionality", js: true do
  include AuthenticationWorkflow
  include WebHelper

  describe "enabling embedded shopfronts" do
    before do
      Spree::Config[:enable_embedded_shopfronts] = false
    end

    it "disables iframes by default" do
      visit shops_path
      expect(page.response_headers['X-Frame-Options']).to eq 'DENY'
    end

    it "allows iframes on certain pages when enabled in configuration" do
      quick_login_as_admin

      visit spree.edit_admin_general_settings_path

      check 'enable_embedded_shopfronts'
      click_button 'Update'

      visit shops_path
      expect(page.response_headers['X-Frame-Options']).to be_nil
    end
  end
end