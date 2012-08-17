window.toggleTimes = (obj) ->
  if $(obj.target).is(':checked')
    $('#business_open_by_appointment').attr('checked', false)
    $('#business_open_by_appointment').attr('disabled', 'disabled')
    $('#business_open_24_hours').attr('checked', false)
    $('#business_open_24_hours').attr('disabled', 'disabled')
    $.each ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'], (i,day)->
      $('#business_'+day+'_enabled').attr('checked', false)
      $('#business_'+day+'_enabled').attr('disabled', 'disabled')
      $('#business_'+day+'_open').attr('disabled', 'disabled')
      $('#business_'+day+'_close').attr('disabled', 'disabled')
    $(obj.target).removeAttr('disabled')
    $(obj.target).attr('checked', true)
  else
    $('#business_open_by_appointment').attr('checked', false)
    $('#business_open_by_appointment').removeAttr('disabled')
    $('#business_open_24_hours').attr('checked', false)
    $('#business_open_24_hours').removeAttr('disabled')
    $.each ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'], (i,day)->
      $('#business_'+day+'_enabled').removeAttr('disabled')
      $('#business_'+day+'_open').removeAttr('disabled')
      $('#business_'+day+'_close').removeAttr('disabled')

$(document).ready ->
  $('#business_open_24_hours').click window.toggleTimes
  $('#business_open_by_appointment').click window.toggleTimes
  $('.timeitem').click (e)->
    wrapper = $(e.target).closest('.timerow')
    checkbox = wrapper.find('input:checkbox')
    checkbox.attr('checked', true)
