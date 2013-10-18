# Business form

#= require jquery.optionTree
#= require form/validations
# = require form/listing_finder
#= require form/business_details
#= require form/payment_methods
#= require form/business_hours
#= require form/categories
#= require form/uploader
# = require form/company_description

###
delay_task_sync_button = ->
  if window.location.search.indexOf("delay=true") > 0
    $("form.new_task > input[type='image']").attr('disabled','disabled')
    window.enable_sync_button = ->
      $("form.new_task > input[type='image']").removeAttr('disabled')
    window.setTimeout window.enable_sync_button, 5 * 60 * 1000

auto_download_client_software = ->
  download = -> window.location = document.getElementById('download_client').href 
  window.setTimeout download, 2000
  window.setTimeout has_client_checked_in, 15000

has_client_checked_in = () ->
  $.ajax
    dataType: "text"
    url: "/businesses/client_checked_in/#{window.business_id}"
    success: (data, status, response) ->
      if data == 'yes'
        window.location = "/businesses/tada/#{window.business_id}"
      else
        window.setTimeout has_client_checked_in, 10000
###

$ ->

  return if $("form").is(".new_business, .edit_business") isnt true

  $('[data-toggle="popover"]').popover({trigger: "hover"})
  
  window.business_id = '#{@business.id}'

  colorbox_params = 
    reposition:true
    scalePhotos:true
    scrolling:false
    previous:'<i class="icon-arrow-left"></i>'
    next:'<i class="icon-arrow-right"></i>'
    close:'&times;'
    current:'{current} of {total}'
    maxWidth:'100%'
    maxHeight:'100%'
    onOpen: () ->
      document.body.style.overflow = 'hidden'
    onClosed: () ->
      document.body.style.overflow = 'auto'
    onComplete: () ->
      $.colorbox.resize()

  $('.ace-thumbnails [data-rel="colorbox"]').colorbox(colorbox_params)
  $("#cboxLoadingGraphic").append("<i class='icon-spinner orange'></i>") #let's add a custom loading icon

  $('#input-file-3').ace_file_input
    style:'well',
    btn_choose:'Drop files here or click to choose',
    btn_change:null,
    no_icon:'icon-cloud-upload',
    droppable:true,
    thumbnail:'small'  # large | fit
    preview_error: (filename, error_code) ->
      #name of the file that failed
      #/error_code values
      #/1 = 'FILE_LOAD_FAILED',
      #/2 = 'IMAGE_LOAD_FAILED',
      #/3 = 'THUMBNAIL_FAILED'
      #/alert(error_code);
   # so html can be placed in the dialog title
   
   $.widget "ui.dialog", 
     $.extend {}, $.ui.dialog.prototype, 
       _title: (title) -> 
         if (!this.options.title ) 
           title.html("&#160;")
         else 
           title.html(this.options.title)

   $("#mapbutton").on 'click', (e) => 
      e.preventDefault()

      business_name = $("#business_business_name").val()
      address = $("#business_address").val()
      zip = $("#business_zip").val()
      marker = encodeURIComponent "#{address},#{zip}"

      $("#modalmap img").attr("src","http://maps.googleapis.com/maps/api/staticmap?center=#{marker}&zoom=14&size=400x300&maptype=roadmap&markers=color:blue%7Clabel:A%7C#{marker}&sensor=false")  

      dialog = $("#modalmap").removeClass('hide').dialog
        modal: true
        title: "<div class='widget-header'><h4 class='smaller'><i class='icon-globe'></i> #{business_name}</h4></div>"
        width: 425
        height: 410
        buttons: [ 
          text:  "OK"
          "class": "btn btn-primary btn-xs"
          click: () -> 
            $(this).dialog("close")
          ]


  $('#user_mobile_phone').inputmask("999-999-9999",{ "clearIncomplete": true, 'clearMaskOnLostFocus': true });
  $('#business_local_phone').inputmask("999-999-9999",{ "clearIncomplete": true , 'clearMaskOnLostFocus': true })
  $('#business_alternate_phone').inputmask("999-999-9999",{ "clearIncomplete": true, 'clearMaskOnLostFocus': true })
  $('#business_toll_free_phone').inputmask("999-999-9999",{ "clearIncomplete": true, 'clearMaskOnLostFocus': true })
  $('#business_fax_number').inputmask("999-999-9999",{ "clearIncomplete": true, 'clearMaskOnLostFocus': true })

  #window.initMap()
  #delay_task_sync_button()
  window.company_description()
