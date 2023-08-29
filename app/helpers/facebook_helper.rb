module FacebookHelper
  # def facebook_auth_url
    # client = OmniAuth::Strategies::Facebook.new(ENV['IVIZONE_FACEBOOK_APP_ID'], ENV['IVIZONE_FACEBOOK_APP_SECRET'])
  # end
  #
  # Include escaped wifi_params
  # def fb_permissions_url
  #   "https://www.facebook.com/dialog/oauth?client_id=#{ENV['IVIZONE_FACEBOOK_APP_ID']}&redirect_uri=http%3A%2F%2Fsplash.ivizone.com%2Ffacebook_callback&response_type=token&scope=#{FBSCOPES}&display=touch"
  # end
  def facebook_login_button
    case I18n.locale
    when :fr
      'social/FacebookButton_fr_half.png'
    else
      'social/FacebookButton_en_half.png'
    end
  end

  def linkedin_login_button
    case I18n.locale
    when :fr
      'social/linkedin_en.png'
    else
      'social/linkedin_en.png'
    end
  end

  def instagram_login_button
    # case I18n.locale
    # when :fr
    #   'social/FacebookButton_fr_half.png'
    # else
    #   'social/FacebookButton_en_half.png'
    # end
    'social/instagram_button.png'
  end
end
