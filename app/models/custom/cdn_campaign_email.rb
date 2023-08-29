class Custom::CdnCampaignEmail
  include Aws::Record
  configure_client region: 'eu-west-1'
  set_table_name 'cdn_campaign_emails'

  string_attr   :email, hash_key: true
  string_attr   :campaign
  datetime_attr :initial_registration_time
end
