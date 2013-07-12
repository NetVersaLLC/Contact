# Business form

#= require jquery.optionTree
#= require form/listing_finder
#= require form/business_details
#= require form/payment_methods
#= require form/business_hours
#= require form/categories
#= require form/uploader
#= require form/company_description

save_edits = () ->
  action = $('form.business').attr('action') + '.json'
  $.post action,
    $('form.business').serialize(),

scrollToFirstError = () ->
  $('html,body').animate({'scrollTop':$('.error:first').offset().top-100})

# only for the business.show view
delay_task_sync_button = ->
  if window.location.search.indexOf("delay=true") > 0
    $("form.new_task > input[type='image']").attr('disabled','disabled')
    window.enable_sync_button = ->
      $("form.new_task > input[type='image']").removeAttr('disabled')
    window.setTimeout window.enable_sync_button, 5 * 60 * 1000

auto_download_client_software = ->
  download = -> window.location = document.getElementById('download_client').href 
  window.setTimeout download, 2000
  window.setTimeout has_client_checked_in, 15000

has_client_checked_in = () ->
  $.ajax
    dataType: "text"
    url: "/businesses/client_checked_in/#{window.business_id}"
    success: (data, status, response) ->
      if data == 'yes'
        window.location = "/businesses/tada/#{window.business_id}"
      else
        window.setTimeout has_client_checked_in, 10000

$ ->
  $('.next-button, .back-button, .step-title').click (evt) -> 
    form = $('form.business')
    form.isValid( window.ClientSideValidations.forms[form.attr('id')].validators )
    save_edits()

  # existing accounts
  $('#edit-accounts-area').load "/businesses/#{window.business_id}/accounts/all/edit"

  $('form.business').enableClientSideValidations()

  window.showing_tab= 0
  
  $('.pf-form').psteps( {
    traverse_titles: 'always',
    validate_use_error_msg: false,
    shrink_step_names: false,
    validate_next_step: true,
    ignore_errors_on_next: true,

    steps_show: () ->
      cur_step = $(this)
      #console.log "show #{cur_step.index()}"
      #console.log cur_step.attr('class')
      window.showing_tab = cur_step.index() 

      if cur_step.index() == 7 
        auto_download_client_software()

      if cur_step.index() != 6
        $('form.business').enableClientSideValidations()

    validation_rule: () ->
      errors = 0
      # some useful class items: step-visited step-active last-active
      cur_step = $(this)
      # console.log "validation #{cur_step.index()}"
      #console.log cur_step.attr('class')

      if cur_step.index() == 3 
        if cur_step.hasClass('step-visited')
          $('#section-business-hours .alert-danger').remove() 
          $('#section-payment-methods .alert-danger').remove() 

          unless $(".bussiness_hours_checkbox").is(':checked')
            errors++
            $('#section-business-hours').prepend("<div class='alert alert-danger'>You must check at least one day.</div>") 
          unless $('.payment_method input[type=checkbox]').is(':checked') 
            errors++
            $('#section-payment-methods').prepend("<div class='alert alert-danger'>You must check at least one payment method.</div>") 

          return if errors then 'error' else true

      if cur_step.hasClass("step-visited") && cur_step.find(".error").length > 0 
        scrollToFirstError() if cur_step.hasClass("step-active")
        return 'error' 

      return 'error' if cur_step.find(".error").length > 0
      return cur_step.hasClass("step-visited")
  } )

  window.initMap()
  #delay_task_sync_button()
  window.company_description()

  $('#email').blur ->
    unless $.trim(@value).length
      $(this).css "border-color","red"
    else
      $(this).css "border-color","#CCCCCC"

  $('#password').blur ->
    unless $.trim(@value).length
      $(this).css "border-color","red"
    else
      $(this).css "border-color","#CCCCCC"

  $('#password_confirmation').blur ->
    unless $.trim(@value).length
      $(this).css "border-color","red"
    else
      $(this).css "border-color","#CCCCCC"

  $('#name').blur ->
    unless $.trim(@value).length
      $(this).css "border-color","red"
    else
      $(this).css "border-color","#CCCCCC"

  $('#card_number').blur ->
    unless $.trim(@value).length
      $(this).css "border-color","red"
    else
      $(this).css "border-color","#CCCCCC"

  $('#cvv').blur ->
    unless $.trim(@value).length
      $(this).css "border-color","red"
    else
      $(this).css "border-color","#CCCCCC"

