getCreditCardType = (accountNumber)->
  result = "unknown"
  if /^5[1-5]/.test(accountNumber)
    result = "mastercard"
  else if /^4/.test(accountNumber)
    result = "visa"
  else if /^6/.test(accountNumber)
    result = "discover"
  else if /^3[47]/.test(accountNumber)
    result = "american_express"
  return result

addMessage = (title, desc)->
  html = '<div class="alert alert-block alert-error"><button class="close" data-dismiss="alert" type="button">&times;</button><h4>'
  html += title
  html += '</h4>'
  html += desc
  html += '</div>'
  $('#errors').append(html)

examineCard = ()->
  name = $('#card_number').val()
  current_type = getCreditCardType(name)
  types = ['visa', 'mastercard', 'american_express', 'discover']
  $.each types, (i,type)->
    em = $('#'+type)
    if (current_type == type)
      em.attr('src', '/assets/'+type+'.gif')
      em.addClass('activeCard')
    else
      em.attr('src', '/assets/'+type+'-inactive.gif')
      em.removeClass('activeCard')

formElement = (cond, title, desc, id)->
  console.log(title, cond)
  error = true
  if cond == false
    addMessage(title, desc)
    error = false
  error

window.formElement = formElement

regexMatch = (id, regex)->
  $('#'+id).val().match(regex) != null

requiredElement = (id, name)->
  error = formElement(regexMatch(id, /\S+/), name, name+" is required", name)
  error

formValidates = ()->
  $('#errors').html('')
  error = false
  console.log($('#card_month').val(), $('#card_year').val())
  error = formElement($.payment.validateCardNumber($('#card_number').val()), "Card number", "Card number is not valid", "card_number")
  error = formElement($.payment.validateCardExpiry($('#card_month').val(), $('#card_year').val()), "Expiration date", "Card expiration is invalid", "card_month")
  error = formElement($.payment.validateCardCVC($('#cvv').val()), "CVV", "CVV is invalid", 'cvv')
  error = requiredElement('name', 'Name')
  error = requiredElement('email', 'Email')
  error = requiredElement('password', 'Password')
  error = requiredElement('password_confirmation', 'Password Confirmation')
  unless ($('#tos').is(':checked'))
    addMessage("Terms of Service", "You must agree to the terms of service")
    error = true
  if error == true
    return false
  true

window.registerCheckoutHooks = ()->
  examineCard()
  textbox = $('#card_number')
  textbox.keypress(examineCard)
  textbox.blur(examineCard)
  textbox.payment('formatCardNumber')
  $('#cvv').payment('formatCardCVC')
  $('#submit_button').click (e)->
    if formValidates() == true
      console.log("Form validates!")
      $('#submit_button').attr("disabled", "disabled")
      $('form').submit()
    else
      console.log("Form does not validate!")
    return true
