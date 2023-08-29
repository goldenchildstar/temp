class SponsorAuthorizationRecord
  include Aws::Record

  set_table_name "sponsor_authorization_records_production"

  string_attr   :sponsor_authorization_request_id, hash_key: true
  string_attr   :first_name
  string_attr   :gender
  string_attr   :last_name
  string_attr   :company
  string_attr   :phone
  string_attr   :locale
  string_attr   :visitor_email
  string_attr   :sponsor_email
  datetime_attr :registration_time
  string_attr   :duration
  boolean_attr  :validated
end
