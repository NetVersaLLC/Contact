delete_web_image = (e) -> 
  $("#web_design_web_images_attributes_#{$(e).attr('data-image')}__destroy").val("true") 
  $.post "web_designs/#{window.web_design_id}.json", $(e).closest("form").serialize(), () -> 
    show_web_images()
    $.gritter.add
      class_name: 'gritter-success' 
      text: 'Image deleted successfully'

show_web_images = () -> 
  $.get "web_designs/#{window.web_design_id}.json", (data) -> 
    $("#web_gallery").html( window.web_designs.gallery_template( data ) )
    $(".delete-image").click (e) -> 
      e.preventDefault()
      bootbox.confirm "Are you sure?", (result) ->
        if result 
          delete_web_image(e.currentTarget) 

$ ->
  return if $("#web-designs").length == 0

  window.web_designs = 
    gallery_template: Handlebars.compile($("#gallery-template").html())

  show_web_images()

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
      params: 
        authenticity_token: () -> 
          $("input[name='authenticity_token']").val() 

      #params: params
  ).on 'complete', (event, id, name, response)->
    show_web_images()
    
