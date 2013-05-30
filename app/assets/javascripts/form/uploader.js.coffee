
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

# The numbering (display_name) is tied to the position, so on 
# a delete, we need to get the reordered list to remove any 
# resulting gaps 
refresh_image_list = -> 
  $.getJSON "/images/" + window.business_id + ".json", (images) ->
    $("ul.thumbnails").children().remove()   # clean the slate 
    add_image image for image in images      # add them back in 
    $('.remove_thumbnail').click (e)->       # wire up for deletion 
      delete_image(e)

# ugly looking helper to keep the html out of the way 
add_image = (response) ->
  html = '<li class="span4" id="thumbnail'+response['id']+'"><div class="thumbnail"><img src="'+response['medium']+'" alt=""><h3>'+response['display_name']+'</h3><button class="btn btn-info remove_thumbnail" data-image-id="'+response['id']+'">Remove</button></div></li>'
  $('ul.thumbnails').append(html)


$(document).ready ->
  params                = {}
  csrf_token            = $("meta[name=csrf-token]").attr("content")
  csrf_param            = $("meta[name=csrf-param]").attr("content")
  params[csrf_param]    = encodeURI(csrf_token)
  params["business_id"] = window.business_id

  # wire up existing images to delete button 
  $('.remove_thumbnail').click (e)->  
    delete_image(e)

  $('#uploader').fineUploader(
    request:
      endpoint: '/images'
      params: params
  ).on 'complete', (event, id, name, response)->
    return unless response['success']    
    refresh_image_list()
