class FormRegistration < AuthorizationRecord
  def self.save data, user_agent_data, normalized_parameters
    form_data = data.slice(*valid_form_params)
    authentication_provider          = 'form'
    registration_time                = Time.zone.now

    data_record                      = form_data.merge user_agent_data
    data_record[:authorization_time] = registration_time.to_s
    data_record[:provider]           = authentication_provider

    begin
      registration      = PortalRegistration.create({
        client_mac_address:       normalized_parameters[:normalized_client_mac],
        access_point_mac_address: normalized_parameters[:normalized_ap_mac],
        registration_time:        registration_time,
        authentication_provider:  authentication_provider,
        data:                     data
      })
    rescue ActiveRecord::RecordNotUnique => e
      Rails.logger.debug "Skipping duplicate portal registration entry"
      registration = nil
    end


    Rails.logger.debug "Saved Form Data: #{data_record}"
    return data_record
  end
end
