class Splash::Verification::SponsorController < ::SplashController

  def index
    @template_path = splash_page_template
    Rails.logger.debug "Template path: #{@template_path}"
    render @template_path, layout: nil
  end 

  def register
    @form_registration_data = FormRegistration.save params, extract_user_agent, normalized_parameters

    saved_data   = @form_registration_data.slice('first_name', 'last_name', 'phone', 'email', 'authorization_time', 'custom')
    saved_data['registration_time'] = saved_data.delete('authorization_time')
    saved_data['sponsor_authorization_request_id'] = SecureRandom.uuid
    registration_data = {
      sponsor_authorization_request_id: saved_data['sponsor_authorization_request_id'], 
      first_name: params[:first_name],
      last_name: params[:last_name],
      visitor_email: params[:email],
      sponsor_email: params[:custom][:sponsor_email], 
      registration_time: Time.zone.now
    }

    # store R + id in cache
    save_sponsor_authorization_record registration_data


    # email sponsor
    sponsor_email = registration_data[:sponsor_email]
    Ivizone.sponsor_authorization_request_notification(registration_data).deliver_now if sponsor_email.present?

    # redirect to wait/key
    wait_params = params[:key] = registration_data[:sponsor_authorization_request_id]
    key = registration_data[:sponsor_authorization_request_id]
    organization = params[:organization].present? && params[:organization] || 'transdev'
    authorization_url = Base64.encode64(authorization_url(params))
    redirection_path = "/splash/sponsor/wait/#{organization}/#{key}/#{authorization_url}"
    Rails.logger.debug wait_params
    Rails.logger.debug redirection_path
    redirect_to redirection_path
  end 

  def wait
    organization = params[:organization]
    @key = params[:key]
    @authorization_url = Base64.decode64(params[:authorization_url])
    record = get_sponsor_authorization_record params[:key]
    if record.present? 
      @validated = record.validated
    else 
      @validated = false
    end
    Rails.logger.debug @authorization_url 
    wait_template = "splash/pages/#{organization}/wait"
    render wait_template
  end 

  def verify
    record = get_sponsor_authorization_record params[:key]
    if record.present? 
      if record.validated 
        Rails.logger.debug "Authorization validated"
        render json: {authorized: true}
      else
        render json: {authorized: false}
        Rails.logger.debug "Authorization NOT VALIDATED"
      end
    else
        render json: {error: true}
        Rails.logger.error "Authorization Error"
    end
  end 

  def authorize_registration
    record = get_sponsor_authorization_record params[:key]
    Rails.logger.debug "key: #{params[:key]}"
    if record.present?
      Rails.logger.debug "Authorizing Record"
      record.validated = true 
      record.save

      Rails.logger.debug "Record validated: #{record.validated}"
      @authorization_result_text = "Votre guest est maintenant authorisé à utiliser votre connexion Wifi"
    else
      # something unexpected happened or record expired
      # Alert sponsor to ask user to re-register
      # Should never happen unless records disappear somehow, or the auth key
      # gets screwed
      Rails.logger.debug "Record not found for authorization"
      @authorization_result_text = "Il y avait un problème à authoriser votre guest.  Demander à votre guest de s'incrire de nouveau"
    end
  end
protected

  def save_sponsor_authorization_record data
    sponsor_authorization = SponsorAuthorizationRecord.new
    sponsor_authorization.sponsor_authorization_request_id = data[:sponsor_authorization_request_id]
    sponsor_authorization.first_name = data[:first_name]
    sponsor_authorization.last_name = data[:last_name]
    sponsor_authorization.visitor_email = data[:visitor_email]
    sponsor_authorization.sponsor_email = data[:sponsor_email]
    sponsor_authorization.registration_time = data[:registration_time]
    sponsor_authorization.save
  end

  def get_sponsor_authorization_record key
    SponsorAuthorizationRecord.find sponsor_authorization_request_id: key
  end 

  def splash_page_template
    SplashPage.template params
  end 
end
