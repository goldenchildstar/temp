def meraki_params
  {
    "base_grant_url"    => "https://n56.network-auth.com/splash/grant",
    "user_continue_url" => "https://n56.network-auth.com/splash/connected?hide_terms=true",
    "node_id"           => "3702532",
    "node_mac"          => "00:18:0a:38:7f:04",
    "gateway_id"        => "3702532",
    "client_ip"         => "10.19.73.217",
    "client_mac"        => "d0:23:db:47:d4:b9"
  }.with_indifferent_access
end

def meraki_query
  "?#{meraki_params.to_query}"
end

def wifi_splash_page
  '/splash/ividata' + meraki_query
end

def standard_registration_params
  {
    first_name: 'Test',
    last_name:  'User',
    phone:      '0555555555',
    email:      'test@example.com'
  }.with_indifferent_access
end

def wifi_params
  meraki_params.merge(organization: 'ividata', page: nil).with_indifferent_access
end

def valid_meraki_authorization_url url_params=meraki_params
  continue_url = Rack::Utils.escape post_authorization_url(url_params.except(*Meraki.unnecessary_params))
  url_params[:base_grant_url] + "?continue_url=" + continue_url + Meraki.duration_parameters(60*60*24)
end

def standard_params
  standard_registration_params.merge wifi_params
end

def test_user_agent
  {
    browser:  'Rails',
    version:  '4',
    platform: 'Linux',
    user_agent: 'Rails 4 Linux'
  }
end

