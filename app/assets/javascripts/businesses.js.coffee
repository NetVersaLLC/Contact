# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.storeName = 'TheBathroomSupply'

window.urlsForCheckbox = [
  "https://twitter.com/STORENAME",
  "https://www.facebook.com/pages/STORENAME/128950690507857",
  "http://www.yelp.com/biz/STORENAME",
  "https://foursquare.com/user/5368747",
  "http://www.mapquest.com/places/STORENAME-273654917/",
  "http://orangecounty.citysearch.com/profile/602444911/costa_mesa_ca/STORENAME.html",
  "http://ezlocal.com/ca/costa-mesa/business/710974076",
  "http://www.merchantcircle.com/business/STORENAME.Costa.Mesa.714-437-1571",
  "http://citygrid.com/STORENAME",
  "https://plus.google.com/111638459682317353165/about?enfplm",
  "http://www.kudzu.com/m/STORENAME-19856430",
  "http://local.yahoo.com/info-94176119-STORENAME-costa-mesa-costa-mesa",
  "http://www.yellowbot.com/STORENAME-llc-irvine-ca.html"
]

window.currentCheckbox = 1

window.displayCheckbox = ()->
  num = window.currentCheckbox
  $('#checkbox'+num).html('<img src="/assets/check.png" class="checkicon" />')
  $('#social'+num).html( '<a href="'+window.urlsForCheckbox[num-1].replace("STORENAME", window.storeName)+'">Link to Profile</a>')
  console.log("1")
  if $('#checkbox'+(num+1))
    console.log("2")
    window.currentCheckbox = num+1
    setTimeout(window.displayCheckbox, 1500+Math.random(7000))

window.startJobs = ()->
  window.currentCheckbox = 1
  setTimeout(window.displayCheckbox, 1800)

$(document).ready ->
  $('#startJobs').click ->
    window.startJobs()
  $('#tabs').tabs()
  em = $('#business_mail_password')
  top = em.parent()
  top.html('<input type="password" id="business_mail_password" name="business[mail_password]" placeholder="Password" />')
  console.log top
  

# HACK HACK HACK
# Removal of button is called before the callbacks that add the
# form element. So... delay the remove of the button by one second.
window.removeButton = (obj)->
  calFun = ()->
    $(obj).remove()
  setTimeout(calFun, 1000)

window.openMap = ()->
  html = ''
  $('#map').html(html)
  address = $('#business_address').val()
  address2 = $('#business_address2').val()
  city = $('#business_city').val()
  state = $('#business_state').val()
  zip = $('#business_zip').val()
  if address
    address = [address,address2,city,state,zip].join(" ")
    html = '<iframe width="425" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q='+escape(address)+'&iwloc=A&output=embed&ie=UTF8"></iframe>'
    $('#map').html(html)

window.zipSearch = ()->
  $.getJSON '/zip.js?term='+$('#zip').val(), (data)->
    if data.city
      $('#city').val data['city']
      $('#state').val data['state']

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

window.buildSocial = (names)->
  console.log "Got: ", names
  html = ''
  $.each names, (i,e) ->
    html += '<div style="display: none" id="'+e[1]+'_fields_blueprint">'
    html += '<div class="well">'
    html += '<fieldset class="inputs">'
    html += '<legend>'+e[0]+'</legend>'
    html += '<div class="fields">'
    $.each e[2], (j,f) ->
      html += '<div class="control-group">'
      html += '<label class="control-label" for="business['+e[1]+'_attributes][new_'+[1]+']['+f[1]+']">'+f[1]+'</label>'
      html += '<div class="controls">'
      html += '<input type="'+f[0]+'" size="30" name="business['+e[1]+'_attributes][new_'+e[1]+']['+f[1]+']" id="business_'+e[1]+'_attributes_new_'+e[1]+'_'+f[1]+'">'
      html += '</div>'
      html += '</div>'
    html += '<input type="hidden" value="false" name="business['+e[1]+'_attributes][new_'+e[1]+'][_destroy]" id="business_'+e[1]+'_attributes_new_'+e[1]+'__destroy">'
    html += '<a href="javascript:void(0)" class="remove_nested_fields">Remove '+e[0]+'</a>'
    html += '<br />'
    html += '</fieldset>'
    html += '</div>'
    html += '</div>'
  $('#socialmedia').append( html )

$(document).ready ->
  return if window.defineOnce == true
  window.defineOnce = true
  $('#business_category1').autocomplete
    source: (req, add)->
      $.getJSON "/google_categories/"+$('#business_category1').val(), req, (data)->
        add(data)
  $('#business_category2').autocomplete
    source: (req, add)->
      $.getJSON "/google_categories/"+$('#business_category2').val(), req, (data)->
        add(data)
  $('#business_category3').autocomplete
    source: (req, add)->
      $.getJSON "/google_categories/"+$('#business_category3').val(), req, (data)->
        add(data)

  $('#business_contact_prefix').change (obj)->
    prefix = $(obj.target).val()
    if prefix == 'Mr.'
      $('#business_contact_gender').val('Male')
    else if prefix == 'Mrs.' or prefix == 'Miss.' or prefix == 'Ms.'
      $('#business_contact_gender').val('Female')
  $('#business_open_24_hours').click window.toggleTimes
  $('#business_open_by_appointment').click window.toggleTimes

  $('#business_address').after('<button class="btn btn-info" onclick="window.openMap();" id="mapit">Map</button>')
  $('#business_accounts_attributes_new_email').after('<button class="btn btn-info" onclick="window.detectEmailSettings();">Detect Email Settings</button>')
  $('#mapit').click (event)->
    event.preventDefault()
  $('input[rel=popover]').popover()
  $('#city').autocomplete
    minLength: 3,
    delay: 600,
    disabled: false,
    source: (request, response)->
      $.ajax
        url: "/city.js",
        dataType: "json",
        data:
          state: $('#state').val(),
          term:  request.term
        success: ( data )->
          response( data )
  $('.timeitem').click (e)->
    wrapper = $(e.target).closest('.timerow')
    checkbox = wrapper.find('input:checkbox')
    checkbox.attr('checked', true)
  $('.acceptrow').click (e)->
    if $(e.target).hasClass('checkbox')
      wrapper = $(e.target).closest('.acceptrow')
      checkbox = wrapper.find('input:checkbox')
      if checkbox.is(':checked')
        checkbox.attr('checked', false)
      else
        checkbox.attr('checked', true)
  $('#zipsearch').click window.zipSearch
  $('#zip').blur window.zipSearch
  $('#zipform button').click (event)->
    event.preventDefault()
  $('#search').click ->
    $('#business_results').html('<h3>Loading...</h3>')
    url = '/places.js?state='+escape($('#state').val())+'&'
    url += 'city='+escape($('#city').val())+'&'
    url += 'company_name='+escape($('#company_name').val())
    $.getJSON url, (data)->
      if data['status'] != 'OK'
        $('#business_results').html('<h3>No Results</h3>')
      else
        html = '<table class="table table-bordered"><tbody>'
        $.each data['results'], (i, e)->
          html += '<tr>'
          html += '<td><img src="'+e['icon']+'" /></td>'
          html += '<td>'+e['name']+'</td>'
          html += '<td>'+e['vicinity']+'</td>'
          html += '<td><input type="button" value="Select" class="btn btn-success" data-reference="'+e['reference']+'" onclick="window.selectPlace(this);" /></td>'
          html += '</tr>'
        $('#business_results').html(html)
  window.buildSocial(window.socialAccounts)

window.selectPlace = (el)->
  $.getJSON '/places/show.js?reference='+$(el).attr('data-reference'), (data)->
    if data['status'] == 'OK'
      $('#business_results').html('')
      result = data['result']
      $('#business_business_name').val(result['name'])
      if result['website']
        $('#business_company_website').val(result['website'])
      if result['formatted_phone_number']
        phone = result['formatted_phone_number']
        phone = phone.replace /[()]/g, ''
        phone = phone.replace /\ /g, '-'
        $('#business_local_phone').val phone
      if result['formatted_address']
        addr = result['formatted_address'].split(",")
        $('#business_address').val addr[0]
        $('#business_city').val $('#city').val()
        $('#business_state').val $('#state').val()
        $('#business_zip').val $('#zip').val()
      if result['url']
        $('#business_google_places_url').val result['url']

