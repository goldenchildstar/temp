# Ensure https redirects exist
# Meraki - set page to "the URL they were trying to fetch"
class Splash::PostAuthorizationController < ApplicationController
  def index
    case params[:organization]
    when 'bonduelle'                  then redirect_to "https://www.bonduelle.fr/"         and return
    when 'kenzo'                      then redirect_to "http://www.kenzo.com/"     and return
    when 'devred'                     then handle_devred and return
    else
      render text: "You're authorized: Parameters: #{params.inspect}"
    end
  end

  def handle_devred
    render 'splash/pages/devred/finished'
  end

end
