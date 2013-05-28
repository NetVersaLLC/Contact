# Business form

#= require jquery.optionTree
#= require form/listing_finder
#= require form/business_details
#= require form/payment_methods
#= require form/business_hours
#= require form/categories
#= require form/uploader
#= require form/company_description

###
#
# When a user clicks a tab, the form data is ajaxed 
# to be saved and validated.  If errors are returned, 
# then the current tab is redisplayed with errors.  
# If no errors were found, then they are allowed to move 
# to the requested tab.  
#
# The form data (params) is saved in a separate model, 
# and is used to populate the form if the user signs-out/back in. 
#
# When they are done, they click 'Save' button, which posts 
# in the typical rails routing fashion.  
#
###
save_changes = (event) -> 
  $.ajax
    type: "POST"
    dataType: "html"
    url: "/businesses/save_and_validate"
    data: $('form.business').serialize()
    success: (data, status, response) ->
      $(current_tab_id() + " > section").replaceWith( $(data).find('section') )

      bind_events_on_current_tab()

      if current_tab_has_errors() 
        scrollToFirstError()
        return 'error'

create_business = (event) -> 
  $.post "/businesses",
    $('form.business').serialize(),
    (data, status, response) -> 
      console.log data 
      $('#download_client').attr('href', "/downloads/#{data}") 
      auto_download_client_software() 

wire_up_submit = -> 
  $("form.business").submit ->
    $("#section-save .btn").attr('disabled','disabled')
    $(".ajax-progress").show()

wire_up_cancel = -> 
  $("#section-save .cancel").click -> 
    href = this.href
    $.post '/businesses/cancel_change', () -> 
      window.location = href 
    return false

scrollToFirstError = () -> 
  $('html,body').animate({'scrollTop':$('.error:first').offset().top-100})

# only for the business.show view 
delay_task_sync_button = -> 
  if window.location.search.indexOf("delay=true") > 0 
    $("form.new_task > input[type='submit']").attr('disabled','disabled') 
    window.enable_sync_button = ->
      $("form.new_task > input[type='submit']").removeAttr('disabled')
    window.setTimeout window.enable_sync_button, 60 * 1000


auto_download_client_software = -> 
  download = -> window.location = document.getElementById('download_client').href 
  window.setTimeout download, 2000

window.selectTab = (idx) =>
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


  
  $('.back-button').trigger 'click'
  $('.next-button').trigger 'click'
    


$ ->
  traversal = if $("#new_business").length then 'never' else 'always'
  
  $('.pf-form').psteps( { 
    traverse_titles: traversal, 
    validate_use_error_msg: false,
    shrink_step_names: false, 
    steps_onload: () -> 
      cur_step = $(this)
      $.cookie('last_selected_tab_index', cur_step.index() ) unless cur_step.index()==0

      create_business() if cur_step.hasClass('pstep7') 

    validation_rule: () -> 
      # some useful class items: step-visited step-active last-active 
      cur_step = $(this) 

      # this validates the form in case they hit 'next' without entering anything. 
      form = $('form.business')
      form.isValid( window.ClientSideValidations.forms[form.attr('id')].validators ) 

      if cur_step.hasClass("step-visited") && cur_step.find(".error").length > 0 
        scrollToFirstError() if cur_step.hasClass("step-active") 
        return 'error' 

      #if active then save changes via ajax 

      return cur_step.hasClass("step-visited") 
  } ) 

  

  #$('.next-button').click ->


  #wire_up_submit() 
  #wire_up_cancel()
  #wire_up_tabs() 
  window.initMap()
  delay_task_sync_button() 
  window.company_description()

