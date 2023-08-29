require './lib/splash_page/generator'
require 'optparse'

namespace :splash do

  desc "Generate new splash page from template"
  task :generate, [:manufacturer, :organization, :button_background_color, :fields] => :environment do |t, args|
    manufacturer            = args[:manufacturer] || "meraki"
    organization            = args[:organization]
    button_background_color = args[:button_background_color] || "black"
    button_background_color = button_background_color.present? ? button_background_color : "black"
    fields                  = [args[:fields]].flatten.compact
    show_fields = {}
    fields.each{|field| show_fields[field.to_sym] = true}
    logo_generator = SplashPage::LogoGenerator.new organization: organization
    SplashPage::PageGenerator.new manufacturer: manufacturer, organization: organization, logo_generator: logo_generator, button_background_color: button_background_color, show_fields: show_fields
  end
end
