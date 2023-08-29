class Splash::EmailRegistrationController < Splash::RegistrationController
  def register
    @form_registration_data = FormRegistration.save params, extract_user_agent, normalized_parameters
    Rails.logger.debug "Redirecting client for authorization to: #{meraki_authorization_url}"
    redirect_to meraki_authorization_url
  end

protected


  # Validates that the user accepted terms, and sets any page specific
  # variables that should be displayed on the splash page in case of validation
  # failure.   Then, selects the proper layout for to correctly rerender the
  # splash page in case of validation failure.
  def validate_submission
    @terms = params[:terms]
    @page_variables = SplashPage.set_page_variables params
    custom_layout = SplashPage.layout(params)
    render SplashPage.template(params), layout: custom_layout if invalid_submission?
  end

  def terms_unaccepted?
    @terms.blank?
  end

  def invalid_submission?
    return invalid_email_form? || terms_unaccepted?
  end

  def invalid_email_form?
    @email       = params[:email]
    return @email.blank?
  end
end
