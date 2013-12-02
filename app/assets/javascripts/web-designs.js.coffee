delete_web_image = (e) -> 
  $("#web_design_web_images_attributes_#{$(e).attr('data-image')}__destroy").val("true") 
  $.post "web_designs/#{window.web_designs.id}.json", $(e).closest("form").serialize(), (data) -> 
    edit_web_design( data )
    $.gritter.add
      class_name: 'gritter-success'
      text: 'Image deleted successfully'

get_and_edit_web_design = (id) -> 
  $.get "web_designs/#{id}.json", (data) -> 
    edit_web_design( data )
    
edit_web_design = (data) -> 
  window.web_designs.id = data.id
  $("#edit").html( window.web_designs.edit_template( data ) )
  $(".auth").val( $('meta[name=csrf-token]').attr('content')  )
  
  $("#edit_web_design").on 'submit', (e) -> 
    e.preventDefault() 
    $.post $(this).attr('action'), $(this).serialize(), (data) -> 
      $.gritter.add 
        class_name: 'gritter-success'
        text: 'Changes saved successfully.'
      get_and_show_index()
      
  $(".delete-image").click (e) -> 
    e.preventDefault()
    bootbox.confirm "Are you sure?", (result) ->
      if result 
        delete_web_image(e.currentTarget) 

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
      endpoint: "/web_designs/#{window.web_designs.id}/images.json"
      params: 
        authenticity_token: () -> 
          $("input[name='authenticity_token']").val() 

      #params: params
  ).on 'complete', (event, id, name, response)->
    get_and_edit_web_design( window.web_designs.id )


get_and_show_index = () -> 
  $.get "web_designs.json", (data) -> 
    show_index(data)

show_index = (data) ->
  $("#index").html( window.web_designs.index_template(data) )
  $(".auth").val( $('meta[name=csrf-token]').attr('content')  )

  $(".edit-web-design").click (e) -> 
    $('tr.active').removeClass('active') 
    $(this).closest("tr").addClass('active')
    get_and_edit_web_design( $(this).attr('data-id') )

  $(".delete-web-design").on 'submit', (e) -> 
    e.preventDefault()
    target = this
    bootbox.confirm 'Are you sure?', (result) -> 
      if result 
        $.post $(target).attr('action'), $(target).serialize(), (data) -> 
          $.gritter.add 
            class_name: 'gritter-success'
            text: 'Item deleted'
          get_and_show_index()
          $("#edit").html('')

$ ->
  return if $("#web-designs").length == 0

  window.web_designs = 
    edit_template:  Handlebars.compile($("#edit-template").html())
    index_template: Handlebars.compile($("#index-template").html())

  get_and_show_index()

  # a neat dropdown
  $(".chosen").chosen()

  $("#new_web_design").on "submit", (e) -> 
    e.preventDefault()
    $.post $(this).attr("action") + '.json', $(this).serialize(), (data) -> 
      edit_web_design(data)
      get_and_show_index()

