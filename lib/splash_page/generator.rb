require 'erb'
require 'fileutils'

module SplashPage

  # This class could be converted to an AWS lambda function (or not)
  class LogoGenerator
    attr_accessor :organization, :image_directory, :original_logo_path
    attr_accessor :splash_logo_width, :logo_filename, :logo_filepath
    attr_accessor :logo_height, :logo_width, :logo_extension


    def initialize args
      @organization = args[:organization]
      @image_directory = Pathname.new Rails.root.join('app', 'assets', 'images', 'organizations', organization)
      logo_path = image_directory.join Dir.entries(image_directory).select{|fn| fn =~ /^logo.(png|jpg)$/ }.first
      if logo_path.blank?
        puts "Place place logo in a file named either logo.png or logo.js at the directory path"
        puts "#{image_directory}"
        exit
      end
      @original_logo_path = logo_path
      puts "Using logo found at #{@original_logo_path}"
      @logo_extension     = File.extname original_logo_path
      @splash_logo_width = 300

      resize_for_splash_page
      optimize_filesize
    end

    def get_geometry filepath
      geometry = `identify #{filepath} | cut -d' ' -f3`.chop
    end

    def file_width filepath
      get_geometry(filepath).split('x')[0].to_i
    end

    def file_height filepath
      get_geometry(filepath).split('x')[1].to_i
    end

    def resize_for_splash_page
      resized_filename   = "logo-resized" + logo_extension
      resized_filepath   = image_directory.join resized_filename
      if !File.exists?(original_logo_path)
        puts "Logo not found, please place the logo for #{organization} at"
        puts "#{original_logo_path}"
        exit
      end
      puts "Resizing logo.."
      `convert #{original_logo_path} -resize #{splash_logo_width} #{resized_filepath}`
      puts "Getting logo geometry"
      rename_with_geometry  resized_filepath
    end

    def rename_with_geometry filepath
      geometry       = get_geometry filepath
      @logo_filename = "logo-#{organization}-#{geometry}" + logo_extension
      @logo_filepath = image_directory.join logo_filename
      @logo_height   = file_height filepath
      @logo_width    = file_width  filepath
      `mv #{filepath} #{logo_filepath}`
    end

    def optimize_filesize
      puts "Optimizing logo.."
      case logo_extension.gsub('.', '')
      when 'jpg'
        `jpegoptim --max=90 --strip-all --preserve --totals --all-progressive #{logo_filepath}`
        puts "Optimized logo created at #{logo_filepath}"
      when 'png'
        `optipng -o7 -preserve #{logo_filepath}`
        puts "Optimized logo created at #{logo_filepath}"
      end
    end

    def logo_relative_path
      File.join organization, logo_filename
    end
  end

  class PageGenerator
    attr_accessor :organization, :page_directory

    def initialize args
      logo_generator            = args[:logo_generator]
      manufacturer              = args[:manufacturer]
      organization              = args[:organization]
      registration_button_color = args[:button_background_color] 
      show_fields               = args[:show_fields]
      if show_fields.blank?
        show_fields = {name: true, email: true, phone: true}
      end

      views_dir      = splash_page_templates_for manufacturer
      template_dir   = views_dir.join 'templates'
      page_dir       = views_dir.join organization
      FileUtils.mkdir_p page_dir

      logo_height               = logo_generator.logo_height
      logo_width                = logo_generator.logo_width
      logo_path                 = File.join 'organizations', logo_generator.logo_relative_path

      sms_registration_path     =  "/splash/#{organization}/sms_registration"

      # create index and registration pages
      facebook_template         = ERB.new File.read template_dir.join 'facebook.html.erb'
      registration_template     = ERB.new File.read template_dir.join 'registration.html.erb'

      if sms_capable? manufacturer
        sms_registration_template = ERB.new File.read template_dir.join 'sms_registration.html.erb'
        sms_code_template         = ERB.new File.read template_dir.join 'sms_code.html.erb'
      end

      facebook_haml            = facebook_template.result binding
      registration_haml        = registration_template.result binding
      
      if sms_capable? manufacturer
        sms_registration_template = ERB.new File.read template_dir.join 'sms_registration.html.erb'
        sms_registration_haml    = sms_registration_template.result binding
        sms_code_haml            = sms_code_template.result binding
      end


      IO.write page_dir.join('facebook.html.erb'), facebook_haml
      IO.write page_dir.join('registration.html.erb'), registration_haml
      if sms_capable? manufacturer
        sms_registration_template = ERB.new File.read template_dir.join 'sms_registration.html.erb'
        IO.write page_dir.join('sms_registration.html.erb'), sms_registration_haml
        IO.write page_dir.join('sms_code.html.erb'), sms_code_haml
      end
      return_splash_urls manufacturer, organization
    end

    def splash_page_templates_for manufacturer
      case manufacturer
      when 'meraki'
        Pathname.new Rails.root.join('app', 'views', 'splash', 'pages')
      when 'aruba'
        Pathname.new Rails.root.join('app', 'views', 'splash', 'aruba', 'pages')
      end
    end 

    def sms_capable? manufacturer
      manufacturer == 'meraki'
    end

    def return_splash_urls manufacturer, organization
      puts "Splash pages available at:"
      facebook_page         = "http://splash.ivizone.com/splash/#{manufacturer}/#{organization}/facebook"
      form_page             = "http://splash.ivizone.com/splash/#{manufacturer}/#{organization}/registration"
      if sms_capable? manufacturer
        sms_registration_page = "http://splash.ivizone.com/splash/#{manufacturer}/#{organization}/sms_registration"
        sms_code_page         = "http://splash.ivizone.com/splash/#{manufacturer}/#{organization}/sms_code"
        puts "SMS Registration: #{sms_registration_page}"
      end

      puts "Facebook: #{facebook_page}"
      puts "Form: #{form_page}"
    end 
  end


  # Inputs:
  #   - organization_name
  #   - logo path (or url)
  #   name.file logo.jpg
  def self.generate organization
    logo_generator = LogoGenerator.new organization: organization
    PageGenerator.new organization: organization, logo_generator: logo_generator
  end
end
