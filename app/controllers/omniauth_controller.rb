class OmniauthController < ApplicationController
  before_action :validate_omniauth_params

  def callback
    process_data
    omniauth_complete_url = authorization_url(omniauth_params)
    Rails.logger.debug "OMNIAUTH Complete - AUTHORIZATION URL: #{omniauth_complete_url}"
    redirect_to omniauth_complete_url
  end

  def failure
    Rails.logger.debug "omniauth.auth #{auth_hash}"
    Rails.logger.debug "omniauth.params #{omniauth_params}"
    failure_url = splash_url(omniauth_params.symbolize_keys)
    Rails.logger.error "FAILURE_URL: #{failure_url}"
    redirect_to failure_url
  end

  protected


  def validate_omniauth_params
    if request.env['omniauth.params'].blank?
      Rails.logger.debug "omniauth.auth #{auth_hash}"
      Rails.logger.debug "omniauth.parms #{omniauth_params}"
      Rollbar.log("OAuth parameters not forwarded", 'error', {auth_hash: auth_hash, omniauth_params: omniauth_params})
    end

    Rails.logger.debug "omniauth.auth #{auth_hash}"
    Rails.logger.debug "omniauth.parms #{omniauth_params}"
    unless required_keys.subset? omniauth_params.keys.to_set
      Rails.logger.debug "Debug: omniauth_params: #{omniauth_params}"
      Rollbar.log("OAuth callback is missing some required parameters", 'error', {auth_hash: auth_hash, omniauth_params: omniauth_params})
      redirect_to splash_url(omniauth_params.symbolize_keys)
    end
  end

  def required_keys
    required_meraki_keys   = %w(base_grant_url user_continue_url node_id node_mac gateway_id client_ip client_mac).to_set
    required_aruba_keys    = %w(cmd mac essid ip apname vcname switchip url).to_set

    return required_meraki_keys   if omniauth_params[:base_grant_url].present?
    return required_aruba_keys    if omniauth_params[:apname].present?
  end

  def auth_hash
    request.env['omniauth.auth']
  end

  def omniauth_params
    request.env['omniauth.params'].with_indifferent_access
  end


  def process_data
    wifi_params = {
      'omniauth_params'  => omniauth_params,
      'user_agent'       => extract_user_agent,
      'timestamp'        => Time.zone.now.to_s
    }

    data = auth_hash.merge wifi_params
    Rails.logger.debug "Dataset: #{data.inspect}"
    data = data.except(:extra)
    Rails.logger.debug "Prunved Dataset Extra removed: #{data.inspect}"

    OmniauthRegistration.save data, extract_user_agent
  end
end
