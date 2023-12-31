require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

hostname = ENV['IVIZONE_DEFAULT_URL_HOST'] || `hostname -f`.strip
hostname = "splash.ivizone.com" if Rails.env.production?
IVIZONE_DEFAULT_URL_HOST = hostname

module IvizoneSplash
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.fallbacks = true

    config.action_mailer.default_url_options = { host: IVIZONE_DEFAULT_URL_HOST }
    config.action_mailer.preview_path = "#{Rails.root}/spec/mailer_previews"

    # Added to autoload /lib files
    config.autoload_paths += %W(#{config.root}/lib)
    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.i18n.available_locales = [:en, :fr, :es, :ja, :pt]
    config.middleware.use Rack::Attack
    config.action_dispatch.default_headers.merge!('X-Frame-Options' => 'ALLOW-FROM //player.h-cdn.com;')
  end
end
