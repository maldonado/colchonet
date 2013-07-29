module ApplicationHelper

  def error_explanation(model)
    if model.errors.any?
      content_tag(:div, content_tag(:h2, t('general.form_error')), :id => 'error_explanation')
    end
  end
  
  def error_tag(model, attribute)
    if model.errors.has_key? attribute
      content_tag :div, model.errors[attribute].first, :class => 'error_message'
    end
  end
  
end