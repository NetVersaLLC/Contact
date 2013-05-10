window.zipSearch = (callback)->
  $('#zip_search_form .zipcode-error').hide();
  _callback = callback
  $.getJSON '/zip.js?term='+$('#zip').val(), (data, textStatus)->
    unless data==null
      if data.city
        $('#city').val data['city']
        $('#state').val data['state']
        if(typeof(_callback)=="function")
          _callback()
    else
      $('#zip_search_form .zipcode-error').show();
      $('#business_results').empty()

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
        $('#business_city').val data['city'] #$('#city').val()
        $('#business_state').val data['state'] #$('#state').val()
        $('#business_zip').val data['zip'] # $('#zip').val()
      if result['url']
        $('#business_google_places_url').val result['url']
    #$('#zip_search_form').dialog('close')

$(document).ready ->
  $('#zip').focus (e)-> 
    $('#zip').val('') 
    $('#city').val('') 
    $('#state').val('CA') 

  $('#show_zip_form').click (e)->
    # not a dialog anymore
    #$('#zip_search_form').dialog
    #  width:  800
    #  height: 500
  $('#city').autocomplete
    minLength: 3,
    delay:     600,
    disabled:  false,
    source:    (request, response)->
      $.ajax
        url: "/city.js",
        dataType: "json",
        data:
          state: $('#state').val(),
          term:  request.term
        success: ( data )->
          response( data )

  $('#zipsearch').click ->
    window.zipSearch ->
      $('#company_search').trigger 'click'

  $('#zip').blur window.zipSearch

  $('#zipform button').click (event)->
    event.preventDefault()

  $('#company_search').click ->
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

$(document).ready ()->
#  $('#close_zip_search_form').click ->
#    $('#zip_search_form').dialog('close')
