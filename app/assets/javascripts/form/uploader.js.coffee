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
  $(".set-logo"+image_id).css({ display: "none" })
  request = $.ajax
    type: "PUT",
    url: "/images/set_logo/"+image_id,
    dataType: 'html',
  request.done (data) ->  
    refresh_image_list(image_id)
    $("#thumbnail"+image_id).addClass('active-block')

# The numbering (display_name) is tied to the position, so on 
# a delete, we need to get the reordered list to remove any 
# resulting gaps 
refresh_image_list = (active_image_id) -> 
  $.getJSON "/images.json?business_id=#{window.business_id}", (images) ->
    $("#logo-section ul.thumbnails").children().remove()   # clean the slate
    add_image image for image in images      # add them back in
    $('.remove_thumbnail').click (e)->       # wire up for deletion
      delete_image(e)
    $('.set-logo').click (e)-> 
      set_logo(e)
    $("#thumbnail"+active_image_id).addClass('active-block')
    
    $(".colorbox").each ->
      that = this
      $this = $(this)
      $this.colorbox
        innerWidth:  1080
        innerHeight: 800
        html: ->
          "<form action='/images/#{$this.data("id")}' method='put' data-remote='true'><input type='hidden' name='image[is_crop]' value=1 >  <img src='#{that.href}' id='image-crop-#{$this.data("id")}'  > <input type='hidden' name='image[crop_x]' id='crop-x-#{$this.data("id")}' > <input type='hidden' name='image[crop_y]' id='crop-y-#{$this.data("id")}' > <input type='hidden' name='image[crop_w]' id='crop-w-#{$this.data("id")}' >  <input type='hidden' name='image[crop_h]' id='crop-h-#{$this.data("id")}' > <input type='submit' value='update' data-disable-with='Please wait...' class='btn btn-primary' ><a href='#' class='close-cbox btn'>Cancel</a></form>"

      $(document).bind "cbox_complete", -> 
        $(".close-cbox").click (eventObject) ->
          eventObject.preventDefault()
          $("#cboxClose").click()
        $("#image-crop-#{ $this.data("id") }").Jcrop
          onChange: (coords) ->
            $("#crop-x-#{ $this.data("id") }").val(coords.x)
            $("#crop-y-#{ $this.data("id") }").val(coords.y)
            $("#crop-w-#{ $this.data("id") }").val(coords.w)
            $("#crop-h-#{ $this.data("id") }").val(coords.h)  
          onSelect: (coords) ->
            $("#crop-x-#{ $this.data("id") }").val(coords.x)
            $("#crop-y-#{ $this.data("id") }").val(coords.y)
            $("#crop-w-#{ $this.data("id") }").val(coords.w)
            $("#crop-h-#{ $this.data("id") }").val(coords.h)
          setSelect: [0, 0, 200, 200]
          aspectRatio: 1

          
          
# ugly looking helper to keep the html out of the way 
add_image = (response) ->
  console.log response
  if response.is_logo == true 
    $('#show-logo').html('<img src=' + response.medium + ' />')
    html = '<li class="span4" style="position: relative" id="thumbnail'+response.id+'"><div class="thumbnail"><img id="img'+response['id']+'" src="'+response.medium+'"  alt=""><button class="btn btn-info remove_thumbnail" style="position: absolute; top: 4px; right: 2px;" data-image-id="'+response['id']+'">X</button></div></li>'
  else 
    html = '<li class="span4" style="position: relative" id="thumbnail'+response['id']+'"><div class="thumbnail"><a href="'+response.url+'" class="colorbox" data-id="'+response.id+'" id="img-href-'+response.id+'"   >  <img id="img'+response['id']+'" src="'+response['medium']+'"  alt=""></a><button class="btn btn-info remove_thumbnail" style="position: absolute; top: 4px; right: 2px;" data-image-id="'+response['id']+'">X</button><button class="btn btn-info set-logo" style="position: absolute; top: 4px; right: 40px;" data-image-id="'+response['id']+'">Set as Logo</button></div></li>'

  $('#logo-section ul.thumbnails').append(html)


$(document).ready ->
  params                = {}
  csrf_token            = $("meta[name=csrf-token]").attr("content")
  csrf_param            = $("meta[name=csrf-param]").attr("content")
  params[csrf_param]    = encodeURI(csrf_token)
  params["business_id"] = window.business_id
  params["business_form_edit_id"] = window.business_form_edit_id
  
  refresh_image_list()

  # wire up existing images to delete button 
  $('.remove_thumbnail').click (e)->  
    delete_image(e)

  $('.set-logo').click (e)->
    set_logo(e)

  #$(".view-image").click view_image
  $('#uploader').fineUploader(
    validation: 
      allowedExtensions: ['jpg','gif','jpeg','png','bmp']

    request:
      endpoint: '/images'
      params: params
  ).on 'complete', (event, id, name, response)->
    return unless response['success']    
    refresh_image_list()
