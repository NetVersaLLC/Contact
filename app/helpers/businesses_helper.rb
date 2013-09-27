module BusinessesHelper
  def form_group(form, field, css=nil)
    a = form.label field.to_sym
    b = form.text_field field.to_sym, class: "form-control #{css}",
        data: { content: I18n.t("popovers.business.#{field}.content"), 
            title: I18n.t("popovers.business.#{field}.title"), 
            :toggle => 'popover'}
    a + b
  end 
  def form_group_select(form, field, items)
    a = form.label field.to_sym
    b = form.select field.to_sym, items, {}, {class: "form-control", 
        data: { content: I18n.t("popovers.business.#{field}.content"), 
            title: I18n.t("popovers.business.#{field}.title"), 
            :toggle => 'popover'} }
    a + b
  end 
end
