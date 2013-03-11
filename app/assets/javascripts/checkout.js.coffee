getCreditCardType = (accountNumber)->
  result = "unknown"
  if /^5[1-5]/.test(accountNumber)
    result = "mastercard"
  else if /^4/.test(accountNumber)
    result = "visa"
  else if /^6/.test(accountNumber)
    result = "discover"
  else if /^3[47]/.test(accountNumber)
    result = "americanexpress"
  return result

examineCard = ()->
  name = $('#card_number').val()
  current_type = getCreditCardType(name)
  types = ['visa', 'mastercard', 'americanexpress', 'discover']
  $.each types, (i,type)->
    em = $('#'+type)
    if (current_type == type)
      em.attr('src', 'cards/'+type+'.gif')
      em.addClass('activeCard')
    else
      em.attr('src', 'cards/'+type+'-inactive.gif')
      em.removeClass('activeCard')

$(document).ready ()->
  textbox = $('#card_number')
  textbox.keypress(examineCard)
  textbox.blur(examineCard)
  textbox.payment('formatCardNumber')
  $('#checkout button').click (e)->
    $('#checkout button').attr("disabled", "disabled")
    if ($.payment.validateCardNumber(textbox.val()) == true)
      $('#checkout').submit()
    return true
