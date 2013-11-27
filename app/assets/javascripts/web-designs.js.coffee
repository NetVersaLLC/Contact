$ ->
  return if $("#web-designs").length == 0

  # a neat dropdown
  $(".chosen").chosen()

  $("#new_web_design").on "submit", (e) -> 
    e.preventDefault()
    $.post $(this).attr("action") + '.json', $(this).serialize(), (data) -> 
      console.log data

  $('#web_uploader').fineUploader(
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
      endpoint: "/web_designs/#{window.web_design_id}/images.json"

      #params: params
  ).on 'complete', (event, id, name, response)->
    html = $("#new-image").html() 
    html = html.replace(/<%=id%>/g, response.id) 
    html = html.replace(/<%=src%>/g, response.url) 

    elements = $(html).appendTo("#gallery")
    #bind_gallery_item(elements[0])
