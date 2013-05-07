window.openMap = ()->
  html = ''
  $('#map').html(html)
  address  = $('#business_address').val()
  address2 = $('#business_address2').val()  
  city     = $('#business_city').val()
  state    = $('#business_state').val()
  zip      = $('#business_zip').val()
  if address
    address = [address,address2,city,state,zip].join(" ")
    html = '<iframe width="425" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q='+escape(address)+'&iwloc=A&output=embed&ie=UTF8"></iframe>'
    $('#map').html(html)

window.initMap = () =>

  $('#business_contact_prefix').change (obj)->
    prefix = $(obj.target).val()
    if prefix == 'Mr.'
      $('#business_contact_gender').val('Male')
    else if prefix == 'Mrs.' or prefix == 'Miss.' or prefix == 'Ms.'
      $('#business_contact_gender').val('Female')
  $('#business_address').after('<button class="btn btn-info" onclick="window.openMap();" id="mapit">Map</button>')
  $('#mapit').click (event)->
    event.preventDefault()
  $('#business_contact_birthday').datepicker()

