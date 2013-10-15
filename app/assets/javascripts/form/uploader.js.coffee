  
#delete_image = (e)->
#  e.preventDefault()
#  image_id = $(e.target).attr('data-image-id')
#  $.ajax
#    type: "POST",
#    url: "/images/"+image_id+".json",
#    data: {_method: "delete"},
#    success: (data)->
#      refresh_image_list()  # the delete action on the controller 
#                            # will get the positions reordered, 
#

# The numbering (display_name) is tied to the position, so on 
# a delete, we need to get the reordered list to remove any 
# resulting gaps 
#refresh_image_list = (active_image_id) ->
#  $.getJSON "/images.json?business_id=#{window.business_id}", (images) ->
#    $("#logo-section ul.thumbnails").children().remove()   # clean the slate
#    $("#uploader").data("fineuploader").uploader._netUploadedOrQueued = images.length if $("#uploader").data("fineuploader")
#    #console.log "images length :#{ images.length  } " if $("#uploader").data("fineuploader")
#    add_image image for image in images      # add them back in
#    $('.remove_thumbnail').click (e)->       # wire up for deletion
#      delete_image(e)
#    $('.set-logo').click (e)->
#      set_logo(e)
#    $("#thumbnail"+active_image_id).addClass('active-block')
#
## ugly looking helper to keep the html out of the way 
#add_image = (response) ->
#  if response.is_logo == true
#    $('#show-logo').html('<img src=' + response.medium + ' />')
#    html = '<li class="span4" style="position: relative" id="thumbnail'+response.id+'"><div class="thumbnail"><img id="img'+response['id']+'" src="'+response.medium+'"  alt=""><button class="btn btn-info remove_thumbnail" style="position: absolute; top: 4px; right: 2px;" data-image-id="'+response['id']+'">X</button></div></li>'
#  else 
#    html = '<li class="span4" style="position: relative" id="thumbnail'+response['id']+'"><div class="thumbnail"><img id="img'+response['id']+'" src="'+response['medium']+'"  alt=""><button class="btn btn-info remove_thumbnail" style="position: absolute; top: 4px; right: 2px;" data-image-id="'+response['id']+'">X</button><button class="btn btn-info set-logo" style="position: absolute; top: 4px; right: 40px;" data-image-id="'+response['id']+'">Set as Logo</button></div></li>'
#
#  $('#logo-section ul.thumbnails').append(html)


$(document).ready ->
  params                = {}
  csrf_token            = $("meta[name=csrf-token]").attr("content")
  csrf_param            = $("meta[name=csrf-param]").attr("content")
  params[csrf_param]    = encodeURI(csrf_token)
  params["business_id"] = window.business_id
  params["business_form_edit_id"] = window.business_form_edit_id


  # wire up existing images to delete button
  $(".delete-image").click (e) ->
    $(this).closest("li").find(".destroy-image").val(true) 
    $(this).closest("li").hide()
    e.preventDefault()


  $gallery = $("#gallery") 
  $logo = $("#logo") 

  $("li", $gallery).draggable
    revert: "invalid" 
    containment: "document" 
    helper: "clone" 
    cursor: "move" 

  $gallery.droppable 
    accept: "#logo > li" 
    activeClass: "ui-state-highlight", 
    drop: (event, ui) -> 
      console.log ui 
      

  $logo.droppable 
    accept: "#gallery li" 
    activeClass: "custom-state-active", 
    drop: (event, ui) -> 

      #$( ".no-logo").hide()
      # move existing logo back to the gallery 
      $("#logo li").appendTo("#gallery") 
      $(ui.draggable).appendTo("#logo .ace-thumbnails")
      
      $("#logo .is-logo").val(true)
      $("#gallery .is-logo").val(false)



  $('#uploader').fineUploader(
    debug: true
    validation:
      allowedExtensions: ['jpg','gif','jpeg','png','bmp']
      itemLimit: 9
    text: 
      uploadButton: '<div><i class="icon-upload icon-white"></i> Click or drag and drop to upload an image.</div>'
    template: '<div class="qq-uploader span12">' +
              '<pre class="qq-upload-drop-area span12"><span>{dragZoneText}</span></pre>' +
              '<div class="qq-upload-button btn btn-success" style="width: auto;">{uploadButtonText}</div>' +
              '<span class="qq-drop-processing"><span>{dropProcessingText}</span><span class="qq-drop-processing-spinner"></span></span>' +
              '<ul class="qq-upload-list" style="margin-top: 10px; text-align: center;"></ul>' +
              '</div>'
    classes: 
      success: 'alert alert-success'
      fail: 'alert alert-error'
    request:
      endpoint: '/images'
      params: params
  ).on 'complete', (event, id, name, response)->
    return unless response['success']
    #refresh_image_list()
    #refresh_image_list()
