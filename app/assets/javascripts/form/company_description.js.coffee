window.company_description = () -> 
  $('#business_business_description').bind 'keydown keyup focus blur', (event) ->

    desc = $(this)
    max = desc.attr('maxlength')
    len = desc.val().length
    if len == max and event.which != 8
      need = 50 - len
      message = if need > 0 then "Need #{need} characters." else "#{len} / #{max}"
      $('#business_business_description_input_help').text(message)
      $(this).val($(this).val().substr(0, max))
      return false
    else if len > max and event.which != 8 # not hitting the backspace key
      $(this).val($(this).val().substr(0, max))
      event.preventDefault()
      return false

    need = 50 - len
    message = if need > 0 then "Need #{need} characters." else "#{len} / #{max}"
    $('#business_business_description_input_help').text(message)
