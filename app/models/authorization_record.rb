class AuthorizationRecord
  def self.valid_form_params
    %i(
       first_name last_name phone email postal_code title mailing_list
       organization page custom locale
       base_grant_url user_continue_url node_id node_mac
       gateway_id client_ip client_mac ssid
       Client_IP Client_MAC Qv SSID ap-mac ap_name hs_server
       page_path rf_domain portal
      )
  end
end
