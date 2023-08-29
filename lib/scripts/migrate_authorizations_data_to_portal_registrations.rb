# rails runner 'Scripts::MigrateAuthorizationsDataToPortalRegistrations.execute'

module Scripts
  module MigrateAuthorizationsDataToPortalRegistrations
    def self.execute
      PortalRegistration.delete_all

      file = Rails.root.join('authorizations.json')
      File.readlines(file).each do |line|
        data                    = JSON.parse(line).with_indifferent_access
        data                    = data.except "_id"
        authentication_provider = data[:provider]
        if data[:timestamp].present? && DateTime.parse(data[:timestamp]) < DateTime.parse("2015-1-1")
          next
        end

        parsed_record = 
          case authentication_provider
          when 'form'
            begin
              mac_addresses     = Adapters::MacAddress.extract_mac_address data
              if mac_addresses[:normalized_ap_mac].blank?
                next
              end
            rescue => e
              if e.class == NoMethodError
                next
              else # Should never happen
                binding.pry
                exit
              end
            end

            registration_time = DateTime.parse data[:authorization_time]

            {
              client_mac_address: mac_addresses[:normalized_client_mac],
              access_point_mac_address: mac_addresses[:normalized_ap_mac],
              authentication_provider: authentication_provider,
              registration_time: registration_time,
              data: data
            }
          else

            mac_addresses     = Adapters::MacAddress.extract_mac_address data[:omniauth_params]
            registration_time = DateTime.parse data[:timestamp]

            begin
              {
                client_mac_address: mac_addresses[:normalized_client_mac],
                access_point_mac_address: mac_addresses[:normalized_ap_mac],
                authentication_provider: authentication_provider,
                registration_time: registration_time,
                data: data
              }
            rescue NoMethodError => e
              if data[:omniauth_params][:portal].blank?
                data[:omniauth_params][:portal] = 'meraki' if data[:omniauth_params][:node_mac].present?
                mac_addresses     = Adapters::MacAddress.extract_mac_address data[:omniauth_params]

                begin
                  {
                    client_mac_address: mac_addresses[:normalized_client_mac],
                    access_point_mac_address: mac_addresses[:normalized_ap_mac],
                    authentication_provider: authentication_provider,
                    registration_time: registration_time,
                    data: data
                  }
                rescue => e
                  binding.pry
                  next # no idea.. skip it
                end
              else
                binding.pry
                exit
              end
            end
          end
         
        # Validate that the data required by the new table is present
        if %i(client_mac_address access_point_mac_address authentication_provider registration_time data).any?{|k| parsed_record[k].blank? }
          puts "Record invalid:"
          puts parsed_record
          binding.pry
          exit
        end 

        begin
          PortalRegistration.create parsed_record
        rescue ActiveRecord::RecordNotUnique => e
          puts "Skipping existing record"
          puts parsed_record
          next
        rescue => e
          binding.pry
        end
      end
    end 
  end
end
