module ApplicationHelper
  def signin_path(provider)
    uri              = Addressable::URI.new
    if meraki_portal?
      query_params = default_splash_meraki_params
    elsif aruba_portal?
      query_params = aruba_parameters.merge(page_parameters)
    end

    uri.query_values = query_params
    path             = "/auth/#{provider.to_s}?#{uri.query}"
    Rails.logger.info "Rendering #{provider.to_s.titleize} Signin Link: #{path}"
    path
  end

  def flash_class(level)
    case level.to_sym
    when :notice  then "alert alert-info"
    when :success then "alert alert-success"
    when :error   then "alert alert-error"
    when :alert   then 'alert alert-danger'
    end
  end

  def alt_page(page, page_params=params)
    splash_url(page_params.symbolize_keys.merge({page: page}))
  end


  def asset_data_uri path
    asset = Rails.application.assets.find_asset path

    throw "Could not find asset '#{path}'" if asset.nil?

    base64 = Base64.encode64(asset.to_s).gsub(/\s+/, "")
    "data:#{asset.content_type};base64,#{Rack::Utils.escape(base64)}"
  end
end
