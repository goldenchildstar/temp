class Ivizone < ActionMailer::Base
  default from: "Sidney Burks <sidney.burks@ividata.com>",
    return_path: 'sidney.burks@ividata.com', to: 'sidney.burks@ividata.com'

  def authentification_notification(data=nil)
    @data = data
    # mail(subject: 'New Meraki Authentification')
  end

  def laposte_officeo_notification(data=nil)
    @data = data
    mail(subject: 'Ivizone - Nouveau Réservation Campagne Officeo',
        return_path: 'sidney.burks@ividata.com, ian.bradac@ividata.com',
        to: 'sidney.burks@ividata.com, ian.bradac@ividata.com, lionel.dibon@laposte.fr')
        # to: 'sidney.burks@ividata.com')
  end

  # def creditdunord_victor_hugo(data=nil)
  #   @data = data
  #   destination = data[:email]
  #   mail(subject: 'Découvrez notre partenariat culturel avec le Palais des Beaux Arts de Lille',
  #       return_path: 'no-reply@ivizonemail.com',
  #       from: 'CREDIT DU NORD <creditdunord@ivizonemail.com>',
  #       to: destination)
  # end
  #
  # def creditdunord_arras(data=nil)
  #   @data = data
  #   destination = data[:email]
  #   mail(subject: 'Découvrez notre partenariat culturel avec le Louvre Lens',
  #       return_path: 'no-reply@ivizonemail.com',
  #       from: 'CREDIT DU NORD <creditdunord@ivizonemail.com>',
  #       to: destination)
  # end

  def bikini_notification(data=nil)
    @data = data
    destination = data[:email]
    mail(subject: 'Ivizone Retail',
        return_path: 'no-reply@ivizonemail.com',
        from: 'BIKINI <ivizone@ivizonemail.com>',
        to: destination)
  end


  def transdev_sponsor_authorization_request_notification(data=nil)
    @data = data
    destination = data[:sponsor_email]
    mail(subject: "Demande d'autorisation d'accès au wifi guest",
        return_path: 'no-reply@ivizonemail.com',
        from: 'Wifi Transdev <transdev@ivizonemail.com>',
        to: destination
    )
  end 

  def transdev_sponsor_authorization_granted_notification(record, code)
    @data = {
      first_name: record.first_name,
      last_name: record.last_name,
      access_code: code
    }
    destination = record.visitor_email
    I18n.with_locale(record.locale) do
      mail(subject: t('transdev.mail.subject'),
          return_path: 'no-reply@ivizonemail.com',
          from: 'Wifi Transdev <transdev@ivizonemail.com>',
          to: destination
      )
    end
  end 

  def ftp_sponsor_authorization_request_notification(data=nil)
    @data = data
    destination = data[:sponsor_email]
    mail(subject: "Demande d'autorisation d'accès au wifi guest",
        return_path: 'no-reply@ivizonemail.com',
        from: 'Wifi FTP <ftp@ivizonemail.com>',
        to: destination
    )
  end 

  def ftp_sponsor_authorization_granted_notification(record, code)
    @data = {
      first_name: record.first_name,
      last_name: record.last_name,
      gender: record.gender,
      access_code: code
    }
    destination = record.visitor_email
    mail(subject: "Code d'autorisation d'accès au wifi guest",
        return_path: 'no-reply@ivizonemail.com',
        from: 'Wifi FTP <ftp@ivizonemail.com>',
        to: destination
    )
  end 

  def eovi_sponsor_authorization_request_notification(data=nil)
    @data = data
    destination = data[:sponsor_email]
    mail(subject: "Demande d'autorisation d'accès au wifi guest",
        return_path: 'no-reply@ivizonemail.com',
        from: 'Wifi Eovi <eovi@ivizonemail.com>',
        to: destination
    )
  end 

  def eovi_sponsor_authorization_granted_notification(record, code)
    @data = {
      first_name: record.first_name,
      last_name: record.last_name,
      gender: record.gender,
      access_code: code
    }
    destination = record.visitor_email
    mail(subject: "Code d'autorisation d'accès au wifi guest",
        return_path: 'no-reply@ivizonemail.com',
        from: 'Wifi Eovi <eovi@ivizonemail.com>',
        to: destination
    )
  end 


  def groupe_vyv_sponsor_authorization_request_notification(data=nil)
    @data = data
    destination = data[:sponsor_email]
    mail(subject: "Demande d'autorisation d'accès au wifi guest",
        return_path: 'no-reply@ivizonemail.com',
        from: 'Wifi Groupe VYV <groupe_vyv@ivizonemail.com>',
        to: destination
    )
  end 

  def groupe_vyv_sponsor_authorization_granted_notification(record, code)
    @data = {
      first_name: record.first_name,
      last_name: record.last_name,
      access_code: code
    }
    destination = record.visitor_email
    I18n.with_locale(record.locale) do
      mail(subject: t('transdev.mail.subject'),
          return_path: 'no-reply@ivizonemail.com',
          from: 'Wifi Groupe VYV <groupe_vyv@ivizonemail.com>',
          to: destination
      )
    end
  end 

  def carnot_sponsor_authorization_request_notification(data=nil)
    @data = data
    destination = data[:sponsor_email]
    mail(subject: "Demande d'autorisation d'accès au wifi guest",
        return_path: 'no-reply@ivizonemail.com',
        from: 'Wifi 22Carnot <carnot@ivizonemail.com>',
        to: destination
    )
  end 

  def carnot_sponsor_authorization_granted_notification(record, code)
    @data = {
      first_name: record.first_name,
      last_name: record.last_name,
      access_code: code
    }
    destination = record.visitor_email
    I18n.with_locale(record.locale) do
      mail(subject: t('carnot.mail.subject'),
          return_path: 'no-reply@ivizonemail.com',
          from: 'Wifi 22Carnot <carnot@ivizonemail.com>',
          to: destination
      )
    end
  end 
end
