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
  console.log("formElment", cond, title, desc, id, error)
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
  errors = []
  errors.push formElement($.payment.validateCardNumber($('#card_number').val()), "Card number", "Card number is not valid", "card_number")
  errors.push formElement($.payment.validateCardExpiry($('#card_month').val(), $('#card_year').val()), "Expiration date", "Card expiration is invalid", "card_month")
  errors.push formElement($.payment.validateCardCVC($('#cvv').val()), "CVV", "CVV is invalid", 'cvv')
  errors.push requiredElement('name', 'Name')
  errors.push requiredElement('email', 'Email')
  if $('#password').length > 0
    errors.push requiredElement('password', 'Password')
    errors.push requiredElement('password_confirmation', 'Password Confirmation')
  unless ($('#user_tos').is(':checked'))
    addMessage("Terms of Service", "You must agree to the terms of service")
    errors.push false
  console.log errors
  validates = true
  $.each errors, (i,e)->
    console.log(e)
    if e == false
      validates = false
  validates

process_coupon = () -> 
  url = '/users/sign_up/process_coupon' + location.search + '&coupon=' + $('#coupon').val()
  $('fieldset.billing_summary').load url, () ->
    $('#addCoupon').click () -> 
      process_coupon()
    $('#removeCoupon').click ()->
      reset_coupon()
    return false 

reset_coupon = () -> 
  url = '/users/sign_up/process_coupon' + location.search 
  $('fieldset.billing_summary').load url, () ->
    $('#addCoupon').click () -> 
      process_coupon()

window.registerCheckoutHooks = ()->
  examineCard()
  $('#addCoupon').click ()->
    process_coupon()
    return false 

    ### 
    url = $.url()
    form = $('form#new_user').get(0)
    form.action = form.action + '?has_coupon='+( $('#coupon').val()!='' )
    form.submit()
    window.location.href='/users/sign_up?package_id='+url.param('package_id')+'&coupon='+$('#coupon').val()
    $('#coupon-show').remove()
    $('#coupon-discount').remove()
    $('#coupon-rest-total').remove()
    $('#amount-reset').remove()
    ###
  textbox = $('#card_number')
  textbox.keypress(examineCard)
  textbox.blur(examineCard)
  textbox.payment('formatCardNumber')
  $('#cvv').payment('formatCardCVC')


#  $('#submit_button').click (e)->
#    if formValidates() == true
#      console.log("Form validates!")
#      $('#submit_button').attr("disabled", "disabled")
#      $('form').submit()
#    else
#      console.log("Form does not validate!")
#    return true
###
  $(".billing-system-close-button").click (e) ->
    $('#amount-reset').show()
    $('#amount-show').remove()
    $('#coupon-rest-total').show()
    $('#coupon-total').remove()
    $('#coupon-discount').remove()
    $('#coupon-price').remove()
    $('#coupon-show').show()
    $(".remove-coupon").remove()
    $(".cross-button").remove()
    $(".coupon-code").remove()
    url = $.url()
    window.location.href='/users/sign_up?package_id='+url.param('package_id')
    ###
