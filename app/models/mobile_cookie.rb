class MobileCookie

  @@table_name = ENV['DYNAMODB_MOBILE_COOKIES_TABLE']

  def self.table_name
    @@table_name
  end

  def self.set_cookie params
    cookie_name = params[:name]
    cookie = {
      value: params[:value],
      expires_at: "#{params[:expires]}"
    }

    update_expression = "SET #{cookie_name} = :value"
    expression_attribute_values = { ":value" => cookie }

    response = AWS_DYNAMODB.update_item({
      table_name: table_name,
      key: {
        client_mac: params[:client_mac]
      },
      update_expression: update_expression,
      expression_attribute_values: expression_attribute_values,
      return_values: "ALL_NEW"
    }).data.attributes.with_indifferent_access
  end

  def self.create phone, code, client_mac, form_data
    response = AWS_DYNAMODB.put_item({
      table_name: table_name,
      item: {
        phone: phone,
        code: code,
        client_mac: client_mac,
        user_data: form_data
      }
    })
  end

  def self.show_all_records
    AWS_DYNAMODB.scan table_name: table_name
  end

  def self.find_by_client_mac client_mac
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

  def self.delete_record client_mac="60:f8:1d:0c:a9:58"
    response = AWS_DYNAMODB.delete_item({
      table_name: table_name,
      key: {
        client_mac: client_mac
      }
    })
  end
end
