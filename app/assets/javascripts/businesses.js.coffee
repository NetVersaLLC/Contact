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

  if current_tab_has_errors() 
    scrollToFirstError()
    return event.preventDefault()
  
  window.new_tab = $(event.target).attr('href')
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
        return 

      $('#current_tab').val(window.new_tab)
      show_tab( window.new_tab )


bind_events_on_current_tab = () -> 
  t = current_tab_id()
  $(t + " > section input[rel=popover]").popover
    trigger: 'hover' 

  $('form.business').enableClientSideValidations()

  window.initMap()             if t == "#tab1" 
  window.businessHours()       if t == "#tab2"
  window.categories()          if t == "#tab4"
  window.company_description() if t == "#tab4"

current_tab_id = () -> 
  $("#current_tab").val() 

tab_count = () -> 
  $(".nav-tabs > li").length

current_tab_has_errors = () -> 
  console.log current_tab_id()
  $(current_tab_id() + " .error").length > 0 

show_tab = ( tab_id ) -> 
  $("a[href='#{tab_id}']").tab('show')

  if $("#next_tab").length > 0 
    next_tab_index = Number(tab_id.charAt(4)) + 1
    if next_tab_index > tab_count() 
      $("input[type='submit']").show() 
      $("#next_tab").hide() 
    else 
      $("#next_tab").attr("href","#tab" + next_tab_index)
      $("input[type='submit']").hide() 
      $("#next_tab").show() 
    console.log tab_id
    console.log next_tab_index
 
wire_up_tabs = () -> 
  $(".tabbable li > a, #next_tab").click (event) -> 
    save_changes( event )
  
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


$ ->
  show_tab( current_tab_id() )
  wire_up_submit() 
  wire_up_cancel()
  wire_up_tabs() 
  window.initMap()
  #business.show 
  delay_task_sync_button() 
  window.company_description()
  


