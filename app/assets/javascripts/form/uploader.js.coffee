window.registerThumbnailHooks = ()->
  $('.remove_thumbnail').click (e)->
    e.preventDefault()
    image_id = $(e.target).attr('data-image-id')
    $.ajax
      type: "POST",
      url: "/images/"+image_id+".json",
      data: {_method: "delete"},
      success: (data)->
        console.log data
        $('#thumbnail'+data['image_id']).remove()

$(document).ready ->
  params                = {}
  csrf_token            = $("meta[name=csrf-token]").attr("content")
  csrf_param            = $("meta[name=csrf-param]").attr("content")
  params[csrf_param]    = encodeURI(csrf_token)
  params["business_id"] = window.business_id
  window.registerThumbnailHooks()
  $('#uploader').fineUploader(
    request:
      endpoint: '/images'
      params: params
  ).on 'complete', (event, id, name, response)->
    return unless response['success']
    html = '<li class="span4" id="thumbnail'+response['id']+'"><div class="thumbnail"><img src="'+response['medium']+'" alt=""><h3>'+response['display_name']+'</h3><button class="btn btn-info remove_thumbnail" data-image-id="'+response['id']+'">Remove</button></div></li>'
    $('ul.thumbnails').append html
    window.registerThumbnailHooks()

