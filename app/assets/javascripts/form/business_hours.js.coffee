window.resetTimes = (options = {} ) ->  
  $.each ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'], (i,day)->
    if day == "monday" and options.skip_monday == true 
    else
      $('#business_'+day+'_enabled').attr('checked', false)
      $('#business_'+day+'_open').val("12:00AM")  #attr('disabled', 'disabled')
      $('#business_'+day+'_close').val("12:00AM") #attr('disabled', 'disabled')

window.copyFromMonday = (day_of_week) -> 
  open  = $('#business_monday_open').val() 
  close = $('#business_monday_close').val() 
  $("#business_monday_enabled").attr('checked',true).change()
  #$('#business_open_by_appointment').attr('checked', false)
  #$('#business_open_24_hours').attr('checked', false)
   
  $("#business_#{day_of_week}_open").val(open) 
  $("#business_#{day_of_week}_close").val(close) 
  $("#business_#{day_of_week}_enabled").attr('checked',true) 

$(document).ready ->
  $('.set_business_hours').click (e)->
    e.preventDefault()
    window.copyFromMonday dow for dow in ['tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'] 

  $('.set_weekday_hours').click (e)->
    e.preventDefault()
    window.resetTimes( {skip_monday: true} ) 
    window.copyFromMonday dow for dow in ['tuesday', 'wednesday', 'thursday', 'friday' ]

  $('#business_open_24_hours').change (e)-> 
    if this.checked 
      $('#business_open_by_appointment').attr('checked', false)
      window.resetTimes() 

  $('#business_open_by_appointment').change (e)-> 
    if this.checked 
      $('#business_open_24_hours').attr('checked', false)
      window.resetTimes()
    
  $.each ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'], (i,day)->
    $("#business_#{day}_enabled").change (e)-> 
      $('#business_open_by_appointment').attr('checked', false)
      $('#business_open_24_hours').attr('checked', false)

  $('.timeitem').click (e)->
    wrapper = $(e.target).closest('.timerow')
    checkbox = wrapper.find('input:checkbox')
    checkbox.attr('checked', true)
