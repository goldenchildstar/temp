# In config/initializers/rack-attack.rb

class Rack::Attack
  bad_urls = %w(
      /clientaccesspolicy.xml
      /testproxy.php
      /user/soapCaller.bs
  )

  blacklist('bad request') do |req|
    bad_urls.include? req.path
  end
end
