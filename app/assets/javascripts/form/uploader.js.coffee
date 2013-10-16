
bind_gallery_item = (item) -> 
  $(item).draggable
    revert: "invalid" 
    containment: "document" 
    helper: "clone" 
    cursor: "move" 

  $(".delete-image", item).click (e) ->
    if confirm( 'Are you sure?') 
      $(this).closest("li").find(".destroy-image").val(true) 
      $(this).closest("li").hide()
    e.preventDefault()

$(document).ready ->
  $("#gallery li").each (index, li) ->
    bind_gallery_item( li )

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
      endpoint: "/businesses/#{window.business_id}/images.json"

      #params: params
  ).on 'complete', (event, id, name, response)->
    html = $("#new-image").html() 
    html = html.replace(/<%=id%>/g, response.id) 
    html = html.replace(/<%=src%>/g, response.url) 

    elements = $(html).appendTo("#gallery")
    bind_gallery_item(elements[0])


