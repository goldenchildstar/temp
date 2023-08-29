class FtpAccessCode
  include Aws::Record

  set_table_name "ftp_access_codes_production"

  string_attr   :access_code, hash_key: true
  string_attr   :duration
  datetime_attr :creation_time
  datetime_attr :last_usage_time
  integer_attr  :usage_count
end
