class Splash::Verification::SmsController < ::SplashController

  def index
    if recently_requested_code? 
      @template_path = sms_entry_template
    else
      @template_path = splash_page_template
    end
    Rails.logger.debug "Template path: #{@template_path}"
    render @template_path, layout: nil
  end

  # TODO: remove vendor-specific
  def register
    @form_registration_data = FormRegistration.save params, extract_user_agent, normalized_parameters
    phone        = params[:phone]
    client_mac   = params[:client_mac]
    ap_mac       = params[:node_mac]
    organization = params[:organization]
    get_user_validation_record client_mac
    code         = generate_code
    saved_data   = @form_registration_data.slice('first_name', 'last_name', 'phone', 'authorization_time', 'custom')
    saved_data['registration_time'] = saved_data.delete('authorization_time')

    store_client_info phone, code, client_mac, saved_data, ap_mac, organization
    send_wifi_authorization_code organization, phone, code
    redirect_to sms_code_entry_link(sms_entry_template)
  end 

  def verify_code
    if code_valid?
      mark_user_as_validated
      redirect_to authorization_url 
    else
      @invalid_code = true
      render sms_entry_template, layout: nil
    end
  end 

  protected

  # TODO: remove vendor-specific
  def sms_code_entry_link page_path
    # This is to make the redirect an absolute path (as opposed to relative
    # filesystem path
    '/' + meraki_link(page_path)
  end 

  # This works by sending the organization name, and using the template naming
  # convention of calling the sms entry page sms_code.html.erb in the
  # organization directory
  def sms_entry_template
    SplashPage.sms_template params
  end 

  def splash_page_template
    SplashPage.template params
  end 

  # TODO: remove vendor-specific
  def code_valid?
    code = params[:custom][:sms]
    get_user_validation_record params[:client_mac]
    Rails.logger.info @validation_record
    @validation_record[:code] == code
  end 

  ####################################################
  #### SMS Controller specific methods -  could be extracted to a concern

  def get_user_validation_record client_mac
    client_mac ||= "."
    @validation_record ||= SmsValidationRecord.find_by_client_mac client_mac
  end

  def mark_user_as_validated
    SmsValidationRecord.mark_as_validated params[:client_mac]
  end

  def generate_code
    if @validation_record.present?
      code = @validation_record[:code]
    else
      code = rand(1000..9999).to_s
    end
    code
  end

  def store_client_info phone, code, client_mac, form_registration_data, ap_mac, organization
    SmsValidationRecord.create phone, code, client_mac, form_registration_data, ap_mac, organization
  end

  def wifi_authorization_message code
    "Votre code accès Wifi: #{code}"
  end 

  def wifi_authorization_sms_sender organization
    case organization
    when 'bonduelle'
      'Bonduelle'
      # This is the bonduelle specific SMS phone number
      # https://www.twilio.com/console/phone-numbers/PN2c4165d14201c06f67a5a1916b38d229
      "+33755537301"
    when 'diderot'
      'Diderot'
    else
      'Wifi Access'
    end
  end 

  def send_wifi_authorization_code organization, phone, code
    message = wifi_authorization_message code
    send_code_via_sms organization, phone, message
  end

  def send_code_via_sms organization, phone, message
    formatted_phone = phone
    client = twilio_client organization
    from = wifi_authorization_sms_sender organization
    client.messages.create(
      from: from,
      to: formatted_phone,
      body: message
    )
  end

  def twilio_client organization
    case organization
    when 'bonduelle'
      @twilio_account_sid = 'ACe232ef80d9ccf4b450f8aa69522a8f8e'
      @twilio_auth_token = '3bf880948b3b6be02e76057daa3c529f'
    when 'diderot'
      @twilio_account_sid = 'ACe0363559fd186777223f315ca136579f'
      @twilio_auth_token = '50ec0a58947b8c9f355fe4438d041e11'
    else
      @twilio_account_sid = 'AC17a50ebd9c4327ece10aa73a49339668'
      @twilio_auth_token = 'c0d8a41d85ce624abd27f5aa09851673'
    end
    @client ||= Twilio::REST::Client.new @twilio_account_sid, @twilio_auth_token
  end

  def sms_sent
    @validation_record && @validation_record[:code].present?
  end 

  def sms_sent_recently?
    @validation_record[:code_sent_at] && @validation_record[:code_sent_at] > 30.minutes.ago
  end 

  def recently_requested_code?
    get_user_validation_record params[:client_mac]
    sms_sent && sms_sent_recently?
  end 
end
