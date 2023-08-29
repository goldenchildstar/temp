require 'rails_helper'

describe Splash::ExternalSplashController do
  context 'when redirecting to the external splash page' do
    before do
      @splash_url      = CGI.escape "http://www.google.com"
      @redirection_url = CGI.escape "http://www.redirection.com"
      external_params  = {
        external_url: @splash_url,
        redirection_url: @redirection_url
      }
      get :redirect, wifi_params.merge(external_params)
    end

    it 'should store the base_grant_url in a session' do
      expect(session[:base_grant_url]).to eq(wifi_params[:base_grant_url])
    end

    it 'should store the node_mac in a session' do
      expect(session[:node_mac]).to eq(wifi_params[:node_mac])
    end

    it 'should store the client_mac in a session' do
      expect(session[:client_mac]).to eq(wifi_params[:client_mac])
    end

    it 'should store the organization in a session' do
      expect(session[:organization]).to eq(wifi_params[:organization])
    end

    it 'should store the page in a session' do
      expect(session[:page]).to eq(wifi_params[:page])
    end

    it 'should store the redirection_url in a session' do
      expect(session[:redirection_url]).to eq(@redirection_url)
    end

    it 'should redirect to the provided splash_url' do
      expected_redirection = CGI.unescape @splash_url
      expect(response).to redirect_to expected_redirection
    end
  end

  context 'authorizing access' do
    xit 'should allow the user to authorize directly' do
      get :authorize, wifi_params
      expect(response).to redirect_to valid_meraki_authorization_url(wifi_params)
    end
  end
end
