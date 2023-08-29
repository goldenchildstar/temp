require 'rails_helper'

describe Splash::RegistrationController do
  let! :standard_params do
    standard_registration_params.merge wifi_params
  end

  xit 'should save the form contents when a user submits them' do
    post :register, standard_params
    allow(PortalRegistration).to receive(:create).and_return(nil)
    expect(response).to redirect_to Meraki.authorization_url(standard_params)
  end

  context 'valid registration' do
    context 'for a standard_registration' do

      xit 'should require a first_name' do
        missing_first_name_params = standard_params.except(:first_name)
        post :register, missing_first_name_params
        expect(response).to render_template SplashPage.template(wifi_params)
      end

      xit 'should require a last_name' do
        missing_last_name_params = standard_params.except(:last_name)
        post :register, missing_last_name_params
        expect(response).to render_template SplashPage.template(wifi_params)
      end

      xit 'should require a email' do
        missing_email_params = standard_params.except(:email)
        post :register, missing_email_params
        expect(response).to render_template SplashPage.template(wifi_params)
      end

      xit 'should require a phone' do
        missing_phone_params = standard_params.except(:phone)
        post :register, missing_phone_params
        expect(response).to render_template SplashPage.template(wifi_params)
      end
    end
  end
end
