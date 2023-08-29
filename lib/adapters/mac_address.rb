module Adapters
  module MacAddress
    def self.extract_mac_address data
      case data[:portal]
      when 'meraki'
        {normalized_client_mac: data[:client_mac], normalized_ap_mac: data[:node_mac]}
      when 'aruba'
        {normalized_client_mac: data[:mac],        normalized_ap_mac: data[:apname]}
      end
    end
  end
end
