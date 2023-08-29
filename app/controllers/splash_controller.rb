class SplashController < ApplicationController

  def index
    extract_user_agent
    display_splash_page
  end

  def page
    Rails.logger.error params
    path = "splash/pages/#{params[:path]}"
    @template_path = path
    render path, layout: nil
  end

  def authorize
    # Get metrics info if necessary
    redirect_to authorization_url
  end

  def alive
    render nothing: true
  end

  def template_path
    template = SplashPage.path_prefix  + params[:template_path]
    render template, layout: nil
  end

  protected

  def display_splash_page
    template_path =  SplashPage.template params

    # if template_path.present?
    #   display page
    # else
    #   use default template
    @page_variables = SplashPage.set_page_variables params


    #
    # Do custom org/network specific work here
    #

    custom_layout = SplashPage.layout params

    # Can't do this, because assets not inlined, and iPhones won't load heavy
    # pages
    # page_html = render_to_string template_path, layout: custom_layout
    # preview_filename = "#{params[:organization]}_#{params[:page] || "index"}.html"
    # IO.write Rails.root.join("previews", preview_filename), page_html

    @template_path = template_path
    render template_path, layout: custom_layout
    Rails.logger.debug "Template path: #{template_path}"
  end
end
