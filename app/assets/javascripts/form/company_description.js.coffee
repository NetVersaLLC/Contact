window.company_description = () -> 
  $('#business_business_description').bind 'keydown keyup focus blur', (event) ->

    desc = $(this)
    max = desc.attr('maxlength')
    len = desc.val().length

    return false if len > max and event.keyCode != 8 # not hitting the backspace key

    need = 50 - len
    message = if need > 0 then "Need #{need} characters." else "#{len} / #{max}"
    $('#business_business_description_input_help').text(message)
