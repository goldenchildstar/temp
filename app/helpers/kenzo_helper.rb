module KenzoHelper

  def kenzo_terms
    case I18n.locale
    when :ja
      'splash/pages/kenzo/terms.ja'
    else
      'splash/ivizone_terms.en'
    end
  end 
end
