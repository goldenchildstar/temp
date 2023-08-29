module MarcJacobsHelper

  def marc_jacobs_terms
    case I18n.locale
    when :ja
      'splash/pages/marc_jacobs/terms.ja'
    else
      'splash/ivizone_terms.en'
    end
  end 
end
