class Splash::RegistrationController < ApplicationController

  def register
    @form_registration_data = FormRegistration.save params, extract_user_agent, normalized_parameters
    Rails.logger.debug "Redirecting client for authorization to: #{authorization_url}"
    redirect_to authorization_url
  end

protected

end
