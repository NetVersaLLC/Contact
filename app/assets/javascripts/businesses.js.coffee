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


bind_events_on_current_tab = () -> 
  t = current_tab_id()
  $(t + " > section input[rel=popover]").popover
    trigger: 'hover' 

  $('form.business').enableClientSideValidations()

  window.initMap()             if t == "#tab1" 
  window.businessHours()       if t == "#tab2"
  window.categories()          if t == "#tab4"
  window.company_description() if t == "#tab4"

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


$ ->
  traversal = if $("#new_business").length then 'never' else 'always'

  $('.pf-form').psteps( { 
    traverse_titles: traversal, 
    validate_use_error_msg: false,
    shrink_step_names: false, 
    steps_onload: () -> 
      cur_step = $(this)  

      auto_download_client_software() if cur_step.hasClass('pstep7') 

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

  #wire_up_submit() 
  #wire_up_cancel()
  #wire_up_tabs() 
  window.initMap()
  delay_task_sync_button() 
  window.company_description()
