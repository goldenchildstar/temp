module Adapters::Aruba
  extend ActiveSupport::Concern

  included do
    helper_method :aruba_parameters
    helper_method :aruba_portal?
    helper_method :default_splash_aruba_params
  end

  def aruba_portal? data={}
    aruba_parameters[:cmd].present? || request.path.include?('/splash/aruba') || data[:portal] == 'aruba'
  end

  def aruba_parameters
    return {} unless params['cmd'].present?
    {
      cmd:       params['cmd'],
      mac:       params['mac'],
      essid:     params['essid'],
      ip:        params['ip'],
      apname:    params['apname'],
      vcname:    params['vcname'],
      switchip:  params['switchip'],
      url:       params['url'],
      page_path: params[:page_path],
      portal:    'aruba'
    }.with_indifferent_access
  end

  def default_splash_aruba_params
    aruba_parameters.merge page_parameters
  end
end
