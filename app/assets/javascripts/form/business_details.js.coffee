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

  params                = {}
  csrf_token            = $("meta[name=csrf-token]").attr("content")
  csrf_param            = $("meta[name=csrf-param]").attr("content")
  params[csrf_param]    = encodeURI(csrf_token)
  params["business_id"] = window.business_id
  $('#uploader').fineUploader(
    request:
      endpoint: '/images'
      params: params
    ).on 'complete', (event, id, name, response)->
    return unless response['success']
    refresh_image_list()
  refresh_image_list()

refresh_image_list = ->
  $.getJSON "/images/" + window.business_id + ".json", (images) ->
    $("ul.thumbnails").children().remove()   # clean the slate
    add_image image for image in images      # add them back in
    $('.remove_thumbnail').click (e)->       # wire up for deletion
      img=confirm("Are you sure you want to Remove Image?")
      if img==true
        delete_image(e)
      else
        e.preventDefault()
        

add_image = (response) ->
  html = '<li class="span4" id="thumbnail'+response['id']+'" ><div class="thumbnail" id="imglogo"><img src="'+response['medium']+'" alt=""><h3>'+response['display_name']+'</h3><button class="btn btn-info remove_thumbnail" data-image-id="'+response['id']+'">Remove</button></div></li>'
  $('ul.thumbnails').append(html)


$("li.span4").live "click",->
  $(this).addClass('bordercolor').siblings().removeClass('bordercolor')
  

    

delete_image = (e)->
  e.preventDefault()
  image_id = $(e.target).attr('data-image-id')
  $.ajax
    type: "POST",
    url: "/images/"+image_id+".json",
    data: {_method: "delete"},
    success: (data)->
      refresh_image_list()  # the delete action on the controller
                            # will get the positions reordered, 

