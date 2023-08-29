class OmniauthRegistration < AuthorizationRecord
  def self.save data, user_agent_data
    data = data.to_hash.merge user_agent_data
    data = data.with_indifferent_access

    registration_time     = Time.zone.now
    normalized_parameters = Adapters::MacAddress.extract_mac_address data[:omniauth_params]
    begin
      registration          = PortalRegistration.create({
        client_mac_address:       normalized_parameters[:normalized_client_mac],
        access_point_mac_address: normalized_parameters[:normalized_ap_mac],
        registration_time:        registration_time,
        authentication_provider:  data[:provider],
        data:                     data
      })
    rescue ActiveRecord::RecordNotUnique => e
      Rails.logger.debug "Skipping duplicate portal registration entry"
      registration = nil
    end
    registration
  end
end
