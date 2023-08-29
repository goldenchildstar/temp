require 'rails_helper'

describe Splash::PageRouterController do
  context "when using a Meraki AP" do
    xit 'should http redirect to the externally hosted page' do
        get :index, meraki_params
        splash_page_url = "https://pages.ivizone.com/owner/campaign_id?test=params"
        expect(response).to redirect_to(splash_page_url)
    end
  end
end
