class Splash::ArubaController < ApplicationController

  def index
    extract_user_agent
    display_splash_page
  end

  def authorize
  
    switch_ip = params[:switchip]
    switch_ip = "securelogin.arubanetworks.com" if switch_ip.blank?
    switch_ip = "wifi-guest.kenzo.com" if switch_ip == "10.40.69.168"
    @post_url = "https://#{switch_ip}/cgi-bin/login"
      
    Rails.logger.info customer_name
    Rails.logger.info "Aruba Post URL:  #{@post_url}"
    @post_url
  end

  protected

  def customer_name
    hostname = request.env["SERVER_NAME"]
    if hostname.include? 'etam'
      return :etam
    end
  end

  def display_splash_page
    organization  = params[:organization]
    page_path     = params[:page_path]
    template_path = Pathname.new(organization).join(page_path)
    full_template_path = "splash/aruba/pages/#{template_path}"
    layout = page_layout organization
    render full_template_path, layout: layout
  end


  def page_layout organization
    basic_template_organizations = %w( ivizone monoprix beip)
    basic_template_organizations.include?(organization) ? 'application' : nil
  end
end