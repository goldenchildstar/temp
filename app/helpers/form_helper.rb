module FormHelper
  def email_error
    'has-error' if form_was_submitted? && @email.blank?
  end

  def first_name_error
    'has-error' if form_was_submitted? && @first_name.blank?
  end

  def last_name_error
    'has-error' if form_was_submitted? && @last_name.blank?
  end

  def phone_error
    'has-error' if form_was_submitted? && @phone.blank?
  end

  def terms_error
    'has-error' if form_was_submitted? && @terms.blank?
  end

  def birthdate_error
    'has-error' if form_was_submitted? && @birthdate.blank?
  end

  def nationality_error
    'has-error' if form_was_submitted? && @nationality.blank?
  end

  def form_was_submitted?
    action_name == 'register'
  end
end
