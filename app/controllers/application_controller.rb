class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  before_action :set_locale
  before_action :prepare_tracking_data

  include Adapters::Aruba
  include Adapters::Meraki

protected

  def set_locale
    Rails.logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    Rails.logger.debug "* Available locales: #{I18n.available_locales.to_sentence}"
    Rails.logger.debug "* Compatible language: #{http_accept_language.compatible_language_from(I18n.available_locales)}"
    Rails.logger.debug "* Preferred language: #{http_accept_language.preferred_language_from(I18n.available_locales)}"
    Rails.logger.debug "* User Preferred Languages: #{http_accept_language.user_preferred_languages}"
    I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
    Rails.logger.debug "* Locale set to '#{I18n.locale}'"

    inferred_locale = http_accept_language.compatible_language_from(I18n.available_locales)
    Rails.logger.debug "Inferred locale: #{inferred_locale} "
    I18n.locale = inferred_locale || I18n.default_locale
    Rails.logger.debug "Set locale: #{I18n.locale} "
  end

  def session_debug
    session.to_hash.to_s
  end

  def page_parameters
    {
      organization: params[:organization],
      page:         params[:page],
      page_path:    params[:page_path],
      duration:     params[:duration]
    }.with_indifferent_access
  end
  helper_method :page_parameters

  def extract_user_agent
    http_user_agent  = request.env['HTTP_USER_AGENT']
    user_agent       = UserAgent.parse http_user_agent
    @user_agent_data = {
      browser:    user_agent.browser,
      version:    user_agent.version.to_s,
      platform:   user_agent.platform,
      user_agent: http_user_agent
    }
  end

  def portal_type data
    return 'meraki'    if meraki_portal?(data) 
    return 'aruba'     if aruba_portal?(data)
  end 

  # TODO: Needs to be thouroughly tested on al manufacturers
  # WARNING: Doesn't work on oauth callbacks
  # - need to use Adapters::MacAddress.extract_mac_address
  # Implemented for hooks feature.   
  # Meraki Verified
  # Aruba Verified
  def normalized_parameters
    {
      normalized_client_mac: meraki_parameters[:client_mac] || aruba_parameters[:mac], 
      normalized_ap_mac:     meraki_parameters[:node_mac]   || aruba_parameters[:apname] 
    }
  end 

  # Cannot put hooks here.  This is a functional method with no side effects
  def authorization_url data=params
    authorization_url_data = data.symbolize_keys
    Rails.logger.debug "AUTHORIZATION URL DATA: #{authorization_url_data}"
    Rails.logger.debug "AUTHORIZATION URL QUERY PARAMS: #{params}"
    Rails.logger.debug "Portal Type:  #{portal_type(data)}"
    return meraki_authorization_url(authorization_url_data)   if meraki_portal?(data)
    return aruba_authorization_url(authorization_url_data)    if aruba_portal?(data)
  end

  def prepare_tracking_data
    organization   = params[:organization]
    page           = params[:page]
    page_path      = params[:page_path]
    user_agent     = request.env['HTTP_USER_AGENT']
    ua             = UserAgent.parse user_agent
    @tracking_data = {
      browser:      ua.browser,
      version:      ua.version.to_s,
      platform:     ua.platform,
      organization: organization,
      page:         page,
      page_path:    page_path,
      user_agent:   user_agent
    }
  end
end
