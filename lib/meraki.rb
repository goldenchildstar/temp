module Meraki
  def self.authorization_url data
    duration = data[:duration] || 60*60*24
    Rails.logger.debug "data: #{data.inspect}"
    continue_url         = Rails.application.routes.url_helpers.post_authorization_url(data.except(*unnecessary_params).symbolize_keys)
    Rails.logger.debug "Continue URL: #{continue_url}"
    escaped_continue_url = Rack::Utils.escape continue_url
    Rails.logger.debug "Escaped Continue URL: #{escaped_continue_url}"
    redirection_url = "#{data[:base_grant_url]}?continue_url=#{escaped_continue_url}#{duration_parameters(duration)}"
    Rails.logger.debug "Redirection URL: #{redirection_url}"
    Rails.logger.debug "Duration: #{duration}"
    Rails.logger.debug "Duration Parameter Strng: #{duration_parameters(duration)}"
    redirection_url
  end

  def self.duration_parameters duration_in_seconds
    return "&duration=#{duration_in_seconds}"
  end

  def self.unnecessary_params
    [:action, :controller, :authenticity_token, :utf8, :base_grant_url]
  end

  def self.clear_all_data mac_address="90:60:f1:ac:30:ee"
    SmsValidationRecord.delete_record mac_address
    MobileCookie.delete_record mac_address
  end
end
