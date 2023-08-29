require 'rails_helper'

describe Splash::PostAuthorizationController do
  it 'should render ok' do
    get :index
    expect(response.status).to eq 200
  end

  xit 'should redirect to the provided redirect_url' do
    expected_redirection = "http://www.google.com"
    @redirection_url = CGI.escape expected_redirection
    get :index, redirection_url: @redirection_url
    expect(response).to redirect_to expected_redirection
  end
end
