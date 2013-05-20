window.company_description = () -> 
  $('#business_business_description').bind 'keyup keydown', (event)-> 
    len = this.value.length
    need = 50 - len
    message = if need > 0 then "Need #{need} characters." else "#{len} / #{this.maxLength}" 
    $('#business_business_description_input .help-inline').last().text(message)
  $('#business_business_description').keyup()
  
