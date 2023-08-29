unless Rails.env.test? 
  Raven.configure do |config|
    config.dsn = 'https://48e3a6abd5004efcaa9bb55d00a25fde:2a2dce2ffec446d59ac5209d60a806aa@sentry.io/106855'
    config.environments = ['staging', 'production']
  end
end
