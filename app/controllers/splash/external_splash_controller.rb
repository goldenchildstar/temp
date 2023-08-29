class Splash::ExternalSplashController < SplashController

  def redirect
    external_splash_page = CGI.unescape params[:external_url].to_s.strip
    store_meraki_params
    redirect_to external_splash_page
  end

  def authorize
    meraki_params = retrieve_meraki_params
    Rails.logger.info "Params: #{params}"
    redirect_to meraki_authorization_url
  end

  protected


  def store_meraki_params
    session[:base_grant_url]  = params[:base_grant_url]
    session[:redirection_url] = params[:redirection_url].strip
    session[:node_mac]        = params[:node_mac]
    session[:client_mac]      = params[:client_mac]
    session[:organization]    = params[:organization]
    session[:page]            = params[:page]
  end

  def retrieve_meraki_params
    params[:base_grant_url]  = session[:base_grant_url]
    params[:redirection_url] = session[:redirection_url]
    params[:node_mac]        = session[:node_mac]
    params[:client_mac]      = session[:client_mac]
    params[:organization]    = session[:organization]
    params[:page]            = session[:page]
  end
end
