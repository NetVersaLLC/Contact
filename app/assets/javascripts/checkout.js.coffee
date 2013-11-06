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
  error = true
  console.log "#{title} #{id}"
  if cond == false
    addMessage(title, desc)
    $("##{id}").css 'border-color', 'red'
    error = false
  error

window.formElement = formElement

regexMatch = (id, regex)->
  $('#'+id).val().match(regex) != null

requiredElement = (id, name)->
  error = formElement(regexMatch(id, /\S+/), name, name+" is required", id)
  error
check_fields =()->
  if $('#card_number').val() == ""
    $('#card_number').focus()
  if $('#cvv').val() == ""
    $('#cvv').focus()
  if $('#email').val() == ""
    $('#email').focus()
  if $('#name').val() == ""
    $('#name').focus()
  if $('#password').val() == ""
    $('#password').focus()
  if $('#password_confirmation').val() == ""
    $('#password_confirmation').focus()

###formValidates = ()->
  $('#errors').html('')
  $('#new_user input, #new_user select').css 'border-color','#CCC'
  error = false
  console.log($('#card_month').val(), $('#card_year').val())
  errors = []
  if $("[name='amount_total']").val() != '0' 
    if $('#card_number').val() == ""
      errors.push formElement($.payment.validateCardNumber($('#card_number').val()), "Card number", "Please Enter a Valid Card number", "card_number")
    else
      errors.push formElement($.payment.validateCardNumber($('#card_number').val()), "Card number", "Card number is not valid", "card_number")
    errors.push formElement($.payment.validateCardExpiry($('#card_month').val(), $('#card_year').val()), "Expiration date", "Card expiration is invalid", "card_month")
    if $('#cvv').val() == ""
      errors.push formElement($.payment.validateCardCVC($('#cvv').val()), "CVV", "CVV is required", 'cvv')
    else
      errors.push formElement($.payment.validateCardCVC($('#cvv').val()), "CVV", "CVV is invalid", 'cvv')
    errors.push requiredElement('name', 'Name')
  errors.push requiredElement('email', 'Email')
  if $('#password').length > 0
    errors.push requiredElement('password', 'Password')
    errors.push requiredElement('password_confirmation', 'Password Confirmation')
  unless ($('#user_tos').is(':checked'))
    addMessage("Terms of Service", "You must agree to the terms of service")
    errors.push false
  validates = true
  $.each errors, (i,e)->
    console.log(e)
    if e == false
      validates = false
  validates
###
process_coupon = () -> 
  url = '/users/sign_up/process_coupon?package_id=' + $('#package_id').val() + '&coupon=' + $('#coupon').val()
  $('#billing-summary').load url, () ->
    $('#addCoupon').click () -> 
      process_coupon()
    $('#removeCoupon').click ()->
      reset_coupon()
    return false 

reset_coupon = () -> 
  url = '/users/sign_up/process_coupon' + location.search 
  $('#billing_summary').load url, () ->
    $('#addCoupon').click () -> 
      process_coupon()

is_not_free = () -> 
  $("#sign-up-total").val() > 0 || $("#sign-up-monthly-fee").val() > 0

window.registerCheckoutHooks = ()->

  examineCard()
  $('#addCoupon').click ()->
    process_coupon()
    return false 

  textbox = $('#card_number')
  textbox.keypress(examineCard)
  textbox.blur(examineCard)
  textbox.payment('formatCardNumber')
  $('#cvv').payment('formatCardCVC')

  validation_options =
    errorElement: 'div'
    errorClass: 'help-block'
    focusInvalid: false
    rules:
      "user[email]": 
        email: true 
        required: true 
      "user[password]":
        required: true
        minlength: 6
      "user[password_confirmation]": 
        required: true 
        equalTo: "#user_password"
      tos: "required"
      "creditcard[name]":
        required: (element) -> 
          is_not_free() 
      "creditcard[number]":
        required: (element) -> 
          is_not_free() 
        creditcard: true
      "creditcard[verification_value]":
        required: (element) -> 
          is_not_free() 
    messages: 
      email: 
        required: "Please provide a valid email."
        email: "Please provide a valid email."
      password: 
        required: "Please specify a password."
        minlength: "Please specify a secure password."
      tos: "Please accept our policy"

    highlight: (e) ->
      $(e).closest('.form-group').removeClass('has-info').addClass('has-error')

    success: (e) ->
      $(e).closest('.form-group').removeClass('has-error') #.addClass('has-info')
      $(e).remove()

    errorPlacement: (error, element) ->
      console.log "error placement"
      ###if(element.is(':checkbox') || element.is(':radio')) 
        controls = element.closest('div[class*="col-"]')
        if(controls.find(':checkbox,:radio').length > 1) controls.append(error)
        else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0))

      else if(element.is('.select2')) 
        error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'))

      else if(element.is('.chosen-select')) 
        error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'))

      else error.insertAfter(element.parent())
      ###
      error.insertAfter(element.parent())
    #submitHandler: (form) -> 
    #invalidHandler: (form) -> 

  $('#new_user').validate( validation_options )

