# Business form

#= require jquery.optionTree
#= require form/listing_finder
#= require form/business_details
#= require form/payment_methods
#= require form/business_hours
#= require form/categories
#= require form/uploader

###
#
# When a user clicks a tab, the form data is ajaxed 
# to be saved and validated.  If errors are returned, 
# then the current tab is redisplayed with the errors.  
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
  window.new_tab = $(event.target).attr('href')
  $.ajax
    type: "POST"
    dataType: "html"
    url: "/businesses/save_and_validate_change"
    data: $('form.business').serialize()
    success: (data, status, response) ->
      t = $('#current_tab').val()  
      $(t + " > section").replaceWith( $(data).find('section') )
      $(t + " > section input[rel=popover]").popover
        trigger: 'hover' 
        
      window.initMap()        if t == "#tab1" 
      window.businessHours    if t == "#tab3"
      window.categories()     if t == "#tab4"

      if $(t + " .error").length == 0 
        $('#current_tab').val(window.new_tab)
        $("[href=#{window.new_tab}]").tab('show')

wire_up_tabs = -> 
  $(".tabbable li > a").click (event) -> 
    save_changes( event )
  
wire_up_submit = -> 
  $("form.business").submit ->
    $("#section-save .btn").attr('disabled','disabled')
    $(".ajax-progress").show()

$ ->
  wire_up_submit() 
  wire_up_tabs() 
  window.initMap()
