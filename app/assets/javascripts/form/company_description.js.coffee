window.company_description = () -> 
  $('#business_business_description').bind 'keydown', (event) -> 

    desc = $(this)
    max = desc.attr('maxlength')
    len = desc.val().length

    return false if len > max and event.keyCode != 8 # not hitting the backspace key

    need = 50 - len
    message = if need > 0 then "Need #{need} characters." else "#{len} / #{max}" 
    $('#business_business_description_input_help').text(message)

  $('#business_business_description').blur ->
    unless $.trim(@value).length
      if $('#business_business_description_input').find('span').hasClass('error-inline')
        $('#business_business_description_input').find('span').html('<span class="error-inline help-inline business-field">Can not be blank</span>')
