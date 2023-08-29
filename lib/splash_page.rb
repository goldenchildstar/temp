module SplashPage
  # ASSERT: template_path exists!
  def self.template data
    page         = data[:page]
    page_path    = data[:page_path]
    organization = data[:organization]

  # TODO: reorganize into better folder
    if page.present?
      path = "#{organization}/#{page}"
    elsif page_path.present?
      path = "#{organization}/#{page_path}"
    else
      path = "#{organization}/index"
    end
    "#{path_prefix}#{path}"
  end

  def self.sms_template data
    page         = data[:page]
    organization = data[:organization]

  # TODO: reorganize into better folder
    path = "#{organization}/sms_code" 
    "#{path_prefix}#{path}"
  end

  def self.path_prefix
    "splash/pages/"
  end

  def self.layout data
    page         = data[:page]
    organization = data[:organization]

    case organization
    when "bonduelle" then nil
    when "kenzo" then nil
    when "euralimentaire" then nil
    when "edf" then nil
    when "club-med" then nil
    when "mob_hotel" then nil
    when "saint_avold" then nil
    when "22carnot" then nil
    else "application"
    end
  end

  def self.set_page_variables data
    page         = data[:page]
    organization = data[:organization]

    variables = {}
    variables
  end
end
