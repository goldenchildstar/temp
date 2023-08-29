class Splash::FtpSponsorController < ApplicationController
  layout false

  before_filter :set_params

  def sponsor
    render  'splash/pages/ftp/sponsor'
  end 

  def register
    @form_registration_data = FormRegistration.save params, extract_user_agent, normalized_parameters

    saved_data   = @form_registration_data.slice('first_name', 'last_name', 'phone', 'email', 'authorization_time', 'custom')
    saved_data['registration_time'] = saved_data.delete('authorization_time')
    saved_data['sponsor_authorization_request_id'] = SecureRandom.uuid
    registration_data = {
      sponsor_authorization_request_id: saved_data['sponsor_authorization_request_id'], 
      # first_name: params[:first_name].strip,
      gender: params[:custom][:gender] == "mr" ? "Monsieur" : "Madame",
      last_name: params[:last_name].strip,
      company: params[:custom][:company].strip,
      phone: params[:phone].strip,
      visitor_email: params[:email].strip,
      sponsor_email: params[:custom][:sponsor_email].strip, 
      registration_time: Time.zone.now
    }

    # store R + id in cache
    save_sponsor_authorization_record registration_data


    # email sponsor
    sponsor_email = registration_data[:sponsor_email]
    Ivizone.ftp_sponsor_authorization_request_notification(registration_data).deliver_now if sponsor_email.present?

    # redirect to wait/key
    params[:key] = registration_data[:sponsor_authorization_request_id]
    redirection_path = ftp_sponsor_wait_path(params)
    Rails.logger.debug redirection_path
    redirect_to redirection_path
  end 

  def wait
    @key = params[:key]
    @authorization_url = authorization_url(params)
    Rails.logger.debug "authorization_url: #{@authorization_url}"

    render 'splash/pages/ftp/wait'
  end 

  def check_verification
    record = get_sponsor_authorization_record params[:key]
    if record.present? 
      if record.validated 
        Rails.logger.debug "Authorization validated"
        render json: {authorized: true, duration: record.duration}
      else
        render json: {authorized: false}
        Rails.logger.debug "Authorization NOT VALIDATED"
      end
    else
        render json: {error: true}
        Rails.logger.error "Authorization Error"
    end
    
  end 

  def access_code
    render 'splash/pages/ftp/access_code'
  end 

  def verify_code
    access_code = FtpAccessCode.find access_code: params[:access_code].strip
    if access_code
      access_code.last_usage_time = Time.zone.now
      access_code.usage_count     = access_code.usage_count + 1
      access_code.save
      redirect_to authorization_url(params.merge({duration: access_code.duration}))
    else
      @invalid_code = true
      render 'splash/pages/ftp/access_code'
    end
  end 

  def authorization_duration
    render 'splash/pages/ftp/authorization_duration'
  end 

  def authorize_registration
    record = validate_guest_record
    if record.validated 
      send_access_codes record
    end
    render 'splash/pages/ftp/authorization_success'
  end 
protected

  def save_sponsor_authorization_record data
    sponsor_authorization = SponsorAuthorizationRecord.new
    sponsor_authorization.sponsor_authorization_request_id = data[:sponsor_authorization_request_id]
    # sponsor_authorization.first_name                       = data[:first_name]
    sponsor_authorization.gender                           = data[:gender]
    sponsor_authorization.last_name                        = data[:last_name]
    sponsor_authorization.company                          = data[:company]
    sponsor_authorization.phone                            = data[:phone]
    sponsor_authorization.visitor_email                    = data[:visitor_email]
    sponsor_authorization.sponsor_email                    = data[:sponsor_email]
    sponsor_authorization.registration_time                = data[:registration_time]
    sponsor_authorization.save
  end

  def get_sponsor_authorization_record key
    SponsorAuthorizationRecord.find sponsor_authorization_request_id: key
  end 

  def set_params
    params[:organization] = 'ftp'
  end 

  def send_access_codes record
    code = rand(1000..999999).to_s

    save_code_to_database code, record.duration
    send_code_via_sms record.phone, code
    send_code_via_email record, code
  end 

  def validate_guest_record
    record = get_sponsor_authorization_record params[:key]
    Rails.logger.debug "key: #{params[:key]}"
    if record.present?
      Rails.logger.debug "Authorizing Record"
      record.validated = true 
      record.duration = params[:duration]
      record.save
      Rails.logger.debug "Record validated: #{record.validated}"
      @authorization_result_text = "Votre guest est maintenant autorisé à utiliser votre connexion Wifi"
    else
      Rails.logger.debug "Record not found for authorization"
      @authorization_result_text = "Il y avait un problème à autoriser votre guest.  Demander à votre guest de s'incrire de nouveau"
    end
    record
  end 


  def save_code_to_database code, duration
    ftp_access_code = FtpAccessCode.new
    ftp_access_code.access_code   = code
    ftp_access_code.duration      = duration
    ftp_access_code.creation_time = Time.zone.now
    ftp_access_code.usage_count   = 0
    ftp_access_code.save
  end 

  def send_code_via_sms phone, code
    begin
      ftp_account_sid = 'AC5fccefec659d95cb2b2df4b2652fe0c5'
      ftp_auth_token = '0613fac2e045ca10eb608353d8f5eeee'
      twilio_account_sid = ftp_account_sid
      twilio_auth_token = ftp_auth_token
      twilio_client ||= Twilio::REST::Client.new twilio_account_sid, twilio_auth_token

      twilio_client.messages.create(
        from: 'FranceTVPub',
        # from: '+33756795480',
        to: phone,
        body: "Votre code d'accès au réseau 'Invité' de France Télévisions Publicité est : #{code}"
      )
    rescue => e
      # rescue all errors if anyone screws up...
    end
  end

  def send_code_via_email record, code
    Ivizone.ftp_sponsor_authorization_granted_notification(record, code).deliver_now 
  end 
end
