require 'rails_helper'

describe SplashController do
  it 'should exist' do
    get :index, organization: 'ividata'
    expect(assigns(:user_agent_data)).to be_a(Hash)
    expect(response).to have_http_status(200)
  end

  context "when supplying an organization" do
    it 'should render the default organization page' do
      get :index, organization: 'ividata'
      expect(response).to render_template('ividata/index')
    end

    xit 'should report an error if an invalid organization is supplied' do
      expect(Rollbar).to receive(:report_message)
      get :index, organization: 'invalid'
      expect(response).to have_http_status(404)
    end

    context "and a page" do
      it "should render the page variant" do
        get :index, organization: 'ividata', page: 'v1'
        expect(response).to render_template('ividata/v1')
      end

      xit "should respond ok when json format is requested" do
        get :index, organization: 'ividata', page: 'v1', format: 'json'
        expect(response).to have_http_status(200)
      end
    end
  end

  context 'opting out' do
    it 'should allow the user to authorize directly' do
      get :authorize, wifi_params
      expect(response).to redirect_to valid_meraki_authorization_url(wifi_params)
    end
  end

  context 'internationalization' do
    it 'should should set the local to en by default' do
      get :index, organization: 'ividata'
      expect(I18n.locale).to eq :en
    end

    xit 'should should set the locale to fr if the user has a french browser' do
      request.headers['HTTP_ACCEPT_LANGUAGE'] = 'fr,en-US:q=0.8,en:q=0.6'
      @request.headers['HTTP_ACCEPT_LANGUAGE'] = 'fr,en-US:q=0.8,en:q=0.6'
      request.env['HTTP_ACCEPT_LANGUAGE'] = 'fr,en-US:q=0.8,en:q=0.6'
      @request.env['HTTP_ACCEPT_LANGUAGE'] = 'fr,en-US:q=0.8,en:q=0.6'
      # get :index, organization: 'ividata', 'HTTP_ACCEPT_LANGUAGE' => 'fr,en-US:q=0.8,en:q=0.6'
      # get :index, organization: 'ividata', 'HTTP_ACCEPT_LANGUAGE' => 'fr-Fr'
      get :index, organization: 'ividata'
      expect(I18n.locale).to eq :fr
    end

    it 'should should set the local to en if the user has an unsupported language in their browser' do
      request.headers['HTTP_ACCEPT_LANGUAGE'] = 'xx,jp-JP:q=0.8,xx:q=0.6'
      get :index, organization: 'ividata'
      # get :index, organization: 'ividata', 'HTTP_ACCEPT_LANGUAGE' => 'xx,jp-JP:q=0.8,xx:q=0.6'
      expect(I18n.locale).to eq :en
    end
  end
end
