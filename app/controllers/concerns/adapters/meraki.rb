module Adapters::Meraki
  extend ActiveSupport::Concern

  included do
    helper_method :meraki_parameters
    helper_method :meraki_portal?
    helper_method :default_splash_meraki_params
    helper_method :meraki_link
  end

  def default_splash_meraki_params
    meraki_parameters.merge page_parameters
  end

  def meraki_link path, query={}
    all_params = default_splash_meraki_params.merge query
    "#{path}?#{all_params.to_query}"
  end

  def meraki_authorization_url data=params
    ::Meraki.authorization_url data
  end

  def meraki_portal? data={}
    meraki_parameters[:base_grant_url].present? || data[:portal] == 'meraki' || (!aruba_portal?(data))
  end

  def meraki_parameters
    return {} unless params[:base_grant_url].present?
    {
      base_grant_url:    params[:base_grant_url],
      user_continue_url: params[:user_continue_url],
      node_id:           params[:node_id],
      node_mac:          params[:node_mac],
      gateway_id:        params[:gateway_id],
      client_ip:         params[:client_ip],
      client_mac:        params[:client_mac],
      portal:            'meraki'
    }.with_indifferent_access
  end

  def default_splash_meraki_params
    meraki_parameters.merge page_parameters
  end
end
