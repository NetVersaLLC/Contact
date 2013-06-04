
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

set_logo = (e)->
  e.preventDefault()
  image_id = $(e.target).attr('data-image-id')
  $('.thumbnails li').removeClass('active-block')
  $("#thumbnail"+image_id).addClass('active-block')
  $('#show-logo').html($("#img"+image_id).attr('src'))
  $('#show-logo').html('<img src=' + $("#img"+image_id).attr('src') + ' />')
  $(".set-logo"+image_id).css({ display: "none" })
  $.ajax
    type: "PUT",
    url: "/images/set_logo/"+image_id,
    data: {_method: "set_logo", id: image_id},
    success: (data)->
      refresh_image_list()  # the delete action on the controller
                            # will get the positions reordered,

# The numbering (display_name) is tied to the position, so on 
# a delete, we need to get the reordered list to remove any 
# resulting gaps 
refresh_image_list = -> 
  $.getJSON "/images.json?business_id=#{window.business_id}&business_form_edit_id=#{window.business_form_edit_id}", (images) ->
    $("ul.thumbnails").children().remove()   # clean the slate
    add_image image for image in images      # add them back in
    $('.remove_thumbnail').click (e)->       # wire up for deletion
      delete_image(e)
    $('.set-logo').click (e)->       # wire up for deletion
      set_logo(e)

# ugly looking helper to keep the html out of the way 
add_image = (response) ->
  html = '<li class="span4" style="position: relative" id="thumbnail'+response['id']+'"><div class="thumbnail"><img id="img'+response['id']+'" src="'+response['medium']+'"  alt=""><h3>'+response['display_name']+'</h3><button class="btn btn-info remove_thumbnail" style="position: absolute; top: 4px; right: 2px;" data-image-id="'+response['id']+'">X</button><button class="btn btn-info set-logo" style="position: absolute; top: 4px; right: 40px;" data-image-id="'+response['id']+'">Set as Logo</button></div></li>'
  $('ul.thumbnails').append(html)



$(document).ready ->
  params                = {}
  csrf_token            = $("meta[name=csrf-token]").attr("content")
  csrf_param            = $("meta[name=csrf-param]").attr("content")
  params[csrf_param]    = encodeURI(csrf_token)
  params["business_id"] = window.business_id
  params["business_form_edit_id"] = window.business_form_edit_id
  console.log params["business_form_edit_id"]
  
  refresh_image_list()

  # wire up existing images to delete button 
  $('.remove_thumbnail').click (e)->  
    delete_image(e)

  $('.set-logo').click (e)->
    set_logo(e)

  $('#uploader').fineUploader(
    request:
      endpoint: '/images'
      params: params
  ).on 'complete', (event, id, name, response)->
    return unless response['success']    
    refresh_image_list()
