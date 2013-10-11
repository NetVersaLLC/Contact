$ ->
  $('#user-wizard').ace_wizard()
    .on 'finished', -> 
      $(".edit_user, .new_user").submit()
    .on 'change', (e, info) -> 
      return $(".edit_user, .new_user").valid()

  validation_rules =  
    "user[first_name]":  
      required: true
    "user[last_name]":  
      required: true
    "user[mobile_phone]":
      required: true 
      phoneUS: true
    "user[data_of_birth]": 
      required: true
      date: true
  
  $('.edit_user, .new_user').validate 
    errorElement: 'div'
    errorClass: 'help-block inline',
    focusInvalid: false,
    rules: validation_rules,

    messages: 
      password: 
        required: "Please specify a password."
        minlength: "Please specify a secure password."
      gender: "Please choose gender"

    highlight: (e) ->
      $(e).closest('.form-group').removeClass('has-info').addClass('has-error')

    success: (e) ->
      $(e).closest('.form-group').removeClass('has-error').addClass('has-info')
      $(e).remove()

    errorPlacement: (error, element) ->
      if(element.is(':checkbox') || element.is(':radio')) 
        controls = element.closest('div[class*="col-"]')
        if(controls.find(':checkbox,:radio').length > 1) controls.append(error)
        else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0))

      else if(element.is('.select2')) 
        error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'))

      else if(element.is('.chosen-select')) 
        error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'))

      else error.insertAfter(element)  #error.insertAfter(element.parent())

    submitHandler:  (form) ->
      form.submit()
    invalidHandler: (form) ->

