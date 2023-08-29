require 'rails_helper'

describe OmniauthController do
  context 'when successful callback' do
    before do
      request.env['omniauth.auth']   = OmniAuth.config.mock_auth[:facebook]
      request.env['omniauth.params'] = wifi_params
    end

    xit 'should redirect to the meraki authorization url, with a post_authorization callback' do
      get :callback, provider: 'facebook'
      expect(response).to redirect_to(valid_meraki_authorization_url(wifi_params))
    end

    context 'when missing parameters in the oauth callback' do
      before do
        request.env['omniauth.params'] = wifi_params.except(:client_mac)
      end

      it 'should redirect to the splash page ' do
        get :callback, provider: 'facebook'
        expect(response).to redirect_to(splash_path(wifi_params.except(:client_mac).symbolize_keys))
      end
    end
  end


  context 'when failure callback' do
    before do
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
      request.env['omniauth.params'] = wifi_params
    end

    it 'should do something' do
      get :failure, provider: 'facebook'
      expect(response).to redirect_to(splash_path(wifi_params.symbolize_keys))
    end
  end
end
