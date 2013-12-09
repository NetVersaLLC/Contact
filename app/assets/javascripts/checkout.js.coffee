getCreditCardType = (accountNumber)->
  result = "unknown"
  if /^5[1-5]/.test(accountNumber)
    result = "master"
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
  $("#creditcard_type").val(current_type)
  types = ['visa', 'master', 'american_express', 'discover']
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
  $('#billing-summary').load url, () ->
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
      error.insertAfter(element.parent())
    #submitHandler: (form) -> 
    #invalidHandler: (form) -> 

  $('#new_user').validate( validation_options )

