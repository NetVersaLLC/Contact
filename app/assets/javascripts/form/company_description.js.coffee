window.company_description = () -> 
  $('#business_business_description').bind 'keyup keydown', (event)-> 
    need = 50 - this.value.length
    message = if need > 0 then "Need #{need} characters." else "" 
    $('#business_business_description_input .help-inline').last().text(message)
  $('#business_business_description').keyup()
  