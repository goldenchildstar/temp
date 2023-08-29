class SmsValidationRecord

  @@table_name = ENV['DYNAMODB_SMS_VALIDATIONS_TABLE']

  def self.table_name
    @@table_name
  end

  def self.create phone, code, client_mac, form_data, ap_mac, organization
    response = AWS_DYNAMODB.put_item({
      table_name: table_name,
      item: {
        phone: phone,
        code: code,
        access_point_mac: ap_mac,
        organization: organization,
        client_mac: client_mac,
        user_data: form_data, 
        code_sent_at: "#{Time.zone.now.utc}"
      }
    })
  end

  def self.show_all_records
    AWS_DYNAMODB.scan table_name: table_name
  end

  def self.find_by_client_mac client_mac
    return unless client_mac.present?

    item = AWS_DYNAMODB.get_item({
      table_name: table_name,
      key: {
        client_mac: client_mac
      },
      consistent_read: true
    }).data.item
    if item.present?
      item = item.with_indifferent_access
    end
    item
  end

  def self.mark_as_validated client_mac
    update_expression = "SET successfully_validated = :value"
    expression_attribute_values = { ":value" => "#{Time.zone.now.utc}" }

    item = AWS_DYNAMODB.update_item({
      table_name: table_name,
      key: {
        client_mac: client_mac
      },
      update_expression: update_expression,
      expression_attribute_values: expression_attribute_values,
      return_values: "ALL_NEW"
    }).data.attributes.with_indifferent_access
  end

  def self.delete_record client_mac
    response = AWS_DYNAMODB.delete_item({
      table_name: table_name,
      key: {
        client_mac: client_mac
      }
    })
  end

end
