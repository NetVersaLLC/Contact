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

create_business = (event) ->
  $.ajax
    type: "POST"
    dataType: "text"
    url: "/businesses.json"
    data: $('form.business').serialize()
    success: (data, status, response) ->
      $('a.back-button').hide()
      console.log data
      window.business_id = data
      $('#download_client').attr('href', "/downloads/#{data}")
      auto_download_client_software()
    error: () -> 
      # this shouldnt happen.  client side validations should handle this
      alert('An error occurrend creating your business profile. Please correct data and resubmit')

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
      console.log data
      if data == 'yes'
        window.location = "/businesses/tada/#{window.business_id}"
      else
        window.setTimeout has_client_checked_in, 10000

window.selectTab = (idx) =>
  return
  $('.steps-transformed .step-title').addClass('disabled')
  $('.steps-transformed .step-title:eq('+idx+')').removeClass('disabled btn-success')
  $('.steps-transformed .step-content').hide()

  g_is_looping = true
  $('.steps-transformed .step-title:lt('+(idx)+')').each ->
    cur_step = $(this)
    cur_step.addClass('btn step-visited btn-success last-active step-active disabled')
    cur_step.prepend('<i class="icon-ok step-mark"></i>') if cur_step.find('.icon-ok').size()==0
    cur_step.unbind().off()

    return if !g_is_looping
    form = $('form.business')
    form.isValid( window.ClientSideValidations.forms[form.attr('id')].validators )
    if cur_step.hasClass("step-visited") && cur_step.find(".error").length > 0
      scrollToFirstError() if cur_step.hasClass("step-active")
      g_is_looping = false

  $('.steps-transformed .step-content:lt('+(idx)+')').each ->
    cur_step = $(this)
    cur_step.addClass('step-content step-visited last-active step-active step-loaded')
    cur_step.hide()
    scrollToFirstError() if cur_step.hasClass("step-active step-error")

  $('.back-button').trigger 'click'
  $('.next-button').trigger 'click'

$ ->

  $('#edit-accounts').hide().load "/businesses/#{window.business_id}/accounts/all/edit", (evt) ->
    $(this).removeClass('loading-accounts')

  last_index = $.cookie('last_selected_tab_index')

  $('.steps-transformed .step-title:lt('+(last_index)+')').each ->
    cur_step = $(this)
    cur_step.addClass('btn step-visited btn-success last-active step-active disabled')
    cur_step.prepend('<i class="icon-ok step-mark"></i>') if cur_step.find('.icon-ok').size()==0
    cur_step.unbind().off()

  $('.pf-form').psteps( {
    traverse_titles: 'always',
    validate_use_error_msg: false,
    shrink_step_names: false,
    validate_next_step: true,
    ignore_errors_on_next: true,

    steps_show: () ->
      cur_step = $(this)
      console.log "show #{cur_step.index()}"
      console.log cur_step.attr('class')
      if cur_step.index() == 6
        $('#edit-accounts').show()
      else 
        $('#edit-accounts').hide()

      if cur_step.index() == 7 
        auto_download_client_software()

    steps_onload: () -> 
      cur_step = $(this)
      $.cookie('last_selected_tab_index', cur_step.index() ) unless cur_step.index()==0
      # $(ClientSideValidations.selectors.forms).validate()
      $('form.business').enableClientSideValidations()
      
      if cur_step.index() == 1
        $('#business_mobile_phone').blur ->
          unless $.trim(@value).length
            if $('#business_mobile_phone_input').find('span').hasClass('error-inline')
              $('#business_mobile_phone_input').find('span').html('<span class="error-inline help-inline">can\'t be blank</span>')
          else
            if $('#business_mobile_phone_input').find('span').hasClass('error-inline')
              $('#business_mobile_phone_input').find('span').html('<span class="error-inline help-inline">Invalid format</span>')

    validation_rule: () ->
      # some useful class items: step-visited step-active last-active
      cur_step = $(this)
      console.log "validation #{cur_step.index()}"
      console.log cur_step.attr('class')

      if cur_step.index() == 0
        form = $('form.business')
        form.enableClientSideValidations()
        form.isValid( window.ClientSideValidations.forms[form.attr('id')].validators )

      if cur_step.index() == 3 && cur_step.hasClass('last-active')
        $('#section-business-hours .alert-danger').remove() 

        if $(".bussiness_hours_checkbox").is(':checked')
          return true
        else 
          $('#section-business-hours').prepend("<div class='alert alert-danger'>You must check at least one day.</div>") 
          return 'error'

      # this validates the form in case they hit 'next' without entering anything.
      if window.is_client_downloaded == true
        form = $('form.business')
        form.isValid( window.ClientSideValidations.forms[form.attr('id')].validators )

      if cur_step.hasClass("step-visited") && cur_step.find(".error").length > 0 
        scrollToFirstError() if cur_step.hasClass("step-active")
        return 'error' 

      if cur_step.hasClass("step-active")
        save_edits()
        create_business() if cur_step.hasClass('pstep6') and $("#new_business").length > 0

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

