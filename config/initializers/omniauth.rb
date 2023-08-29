# https://github.com/nbudin/devise_openid_authenticatable/wiki/Using-devise_openid_authenticatable-with-Heroku-and-Google-Federated-Login
# OpenID.fetcher.ca_file = File.join(Rails.root,'config','certs', 'cacert.pem')

FBSCOPES = "public_profile,email,user_birthday,user_likes"
Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  # http://www.naildrivin5.com/blog/2013/04/29/getting-omniauth-with-google-apps-to-work-on-heroku.html
  # provider :google_apps, domain: 'ividata.com', store: OpenID::Store::Filesystem.new(File.join(Rails.root,'tmp'))
  # https://github.com/zquestz/omniauth-google-oauth2
  # provider :google_oauth2, ENV['IVIZONE_GOOGLE_CLIENT_ID'],      ENV['IVIZONE_GOOGLE_CLIENT_SECRET']
  #TODO: Figure out how to these on a per-request basis
  provider :instagram, ENV['IVIZONE_INSTAGRAM_ID'], ENV['IVIZONE_INSTAGRAM_SECRET']
  # provider :gplus, ENV['IVIZONE_GPLUS_KEY'], ENV['IVIZONE_GPLUS_SECRET'], scope: 'userinfo.email, userinfo.profile'
  provider :google_oauth2, ENV['IVIZONE_GPLUS_KEY'], ENV['IVIZONE_GPLUS_SECRET'], {
    verify_iss: false
  }
  provider :facebook,      ENV['IVIZONE_FACEBOOK_APP_ID'],       ENV['IVIZONE_FACEBOOK_APP_SECRET'],
    scope: FBSCOPES, provider_ignores_state: true, display: 'popup' # skip_info: false, strategy_class: OmniAuth::Strategies::Facebook,
  # provider :twitter,       ENV['IVIZONE_TWITTER_CONSUMER_KEY'],  ENV['IVIZONE_TWITTER_CONSUMER_SECRET']
  provider :linkedin,      ENV['IVIZONE_LINKEDIN_KEY'],          ENV['IVIZONE_LINKEDIN_SECRET']
    # scope: 'r_fullprofile r_emailaddress r_network r_contactinfo',
    # fields: %w(id  first-name last-name headline industry num-connections num-connections-capped summary specialties positions picture-url public-profile-url api-standard-profile-request location) +
    #         %w(email-address) +
    #         %w(last-modified-timestamp proposal-comments associations interests publications patents languages skills certifications educations courses volunteer three-current-positions three-past-positions num-recommenders recommendations-received following job-bookmarks date-of-birth related-profile-views ) +
    #         %w(phone-numbers im-accounts main-address twitter-accounts primary-twitter-account connections )
end

OmniAuth.config.on_failure = Proc.new { |env|
  # OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  OmniauthController.action(:failure).call(env)
}

# OmniAuth.config.logger = Rails.logger
