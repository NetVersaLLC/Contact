
get_job_data = (e) -> 
  job = $(e).closest("tr")
  id:             job.attr("data-job-id") 
  class_name:     job.attr("data-class-name") 
  payload:        job.attr("data-payload")
  status_message: job.attr("data-status-message")

registerHooks = ()->
  $('.rerun').click (e) -> 
    e.preventDefault()
    bootbox.confirm "Are you sure you want to restart the job?", (result) ->
      if result 
        job_post = get_job_data( e.currentTarget ) 
        job_post._method = "put"
        $.post "jobs/" + job_post.id + "/rerun",  job_post, (d) -> 
          $.gritter.add 
            title: "Job restarted" 
            class_name: "gritter-success"

  $('.delete_job').click (e) ->
    e.preventDefault()
    bootbox.confirm "Are you sure?", (result) -> 
      if result 
        job_post = get_job_data( e.currentTarget )
        job_post._method = "delete"
        console.log job_post
        $.post "jobs/" + job_post.id, job_post, (d) -> 
          $(e.currentTarget).closest("tr").remove() 
          $.gritter.add 
            title: "Job deleted" 
            class_name: "gritter-success"

  $('.view_meta').click (e)->
    e.preventDefault() 
    $(e.currentTarget).next().removeClass('hide').dialog
      modal: true 
      title:  "Job Metadata"
      width: 600
      buttons: [
        {
          text: "OK" 
          class: "btn btn-primary btn-xs"
          click: () -> 
            $(this).dialog("close")
        }
      ]

###
  $('.view_booboo').click (e)->
    window.booboo_id = e.target.getAttribute('data-booboo-id')
    console.log window.booboo_id
    $.get '/admin/booboos/'+window.booboo_id+'/view.js', null, (data)->
      $('#view_booboo').html(data['message'])
      $('#view_booboo').dialog( "open" )
  $('.view_notification').click (e)->
    window.notification_id = $(e.target).parent().attr('data-notification-id')
    console.log window.notification_id
    $.get '/notifications/'+window.notification_id+'/edit', (data)->
      $('#view_notification').dialog({autoOpen: false}) 
      $('#view_notification').html(data)
      $('#view_notification').dialog( "open" )
  $('.displayList').sortable
    stop: (event, ui) ->
      em = []
      $('.displayList > li').each (i,e)->
        em.push [i, $(e).attr('data-job-id')]
      console.log em
      $.post '/admin/jobs/'+window.business_id+'/reorder.js', { table: window.current_tab, order: JSON.stringify(em) }, (data)->
        console.log data
  $('.delete_notification').click (e)->
    window.notification_id = $(e.target).parent().attr('data-notification-id')
    if confirm("Are you sure you want to delete this notification?") == true
      $.ajax
        url: "/notifications/#{window.notification_id}"
        type: 'DELETE',
        success: (response)->
          alert("Removed the notification!");
          window.reloadView()
  $('#pause_button').button()
  $('#pause_button').click ->
    $.ajax
      url: "/admin/jobs/toggle_jobs?business_id=#{window.business_id}"
      type: 'PUT',
      success: (response)->
        if response == true
          $('#paused_at').html('Paused')
        else
          $('#paused_at').html('Not Paused')
  $('#load_missed_payloads').button()
  $('#load_missed_payloads').click ->
    $.post "/admin/jobs/add_missing?business_id=#{window.business_id}", (data)->
      alert("Added missing payloads!");
      window.reloadView()
  $('#clear_payloads').button()
  $('#clear_payloads').click ->
    $.ajax
      url: "/admin/jobs/clear_jobs?business_id=#{window.business_id}"
      type: 'DELETE',
      success: (response)->
        alert("Cleared payloads!");
        window.reloadView()
  $('#add_notification_button').button()
  $('#add_notification_button').click (e)->
    $.ajax
      url: '/notifications/new',
      type: 'GET',
      success: (data)->
        $('#view_notification').dialog({autoOpen: false}) 
        $('#view_notification').html(data)
        $('#view_notification').dialog( "open" )

showNotifications = (panel)->
  window.current_tab = "notifications"
  $.get "/notifications.json?business_id=#{window.business_id}", (data)->
    if data == null or data['notifications'].length == 0
      data = 'No notifications'
    else
      data = data['html']
    data = "<div id='dash'><input type='button' id='add_notification_button' value='New Notification' /></div>" + data
    $(panel).html( data )
    registerHooks()

window.loadPayloads = ()->
  $.getJSON '/payloads/'+$('#payload_categories_select').val()+'.json', (data)->
    html = '<ul id="payload_list_ul">'
    $.each data, (i,e)->
      html += '<li class="ui-state-default" data-payload-id="'+e+'">'+e+'</li>'
    html += '</ul>'
    $('#payload_list_container').html(html)
    $('#payload_list_ul > li').click (e)->
      window.payloadListAction(e)

window.clientPayloadListAction = (e)->
  console.log("clientPayloadListAction()")
  match = window.location.href.match(/client_manager/)
  if match != null and match.length > 0
    window.assign_payload = $(e.target).attr('data-payload-id')
    window.payload_post_url = "/jobs?name=#{$('#payload_categories_select').val()}/#{window.assign_payload}&business_id=#{window.business_id}"
    $('#assign_payload').dialog("open")
  else
    window.packagePayloadListAction(e)

window.startPayloads = () ->
  # Setup Payload Categories
  window.payloadListAction = window.clientPayloadListAction
  $.getJSON '/admin/jobs/payloads_categories_list.js', (data)->
    html = '<select id="payload_categories_select" onchange="window.loadPayloads();">'
    $.each data, (i,e)->
      html += '<option value="'+e+'">'+e+'</option>'
    html += '</select><div id="payload_list_container"></div><br />'
    $('#payload_list').html(html)
    window.loadPayloads()
  # Setup Tabs
  actions = [
    showPending,
    showFailed,
    showCompleted,
    showErrors,
    showClient, 
    showLatest,
    showNotifications
  ]
  $('#view_notification').dialog
    autoOpen: false,
    show: "blind",
    hide: "explode"
    width: 500
    buttons:
      Ok: ()->
        notification = $('#notification_form').serialize() + '&notification[business_id]='+window.business_id
        id = $('#notification_id').val()
        if id == ''
          $.ajax
            url: '/notifications',
            type: 'POST',
            data: notification,
            success: ( response ) ->
              window.reloadView()
          $( this ).dialog( "close" )
        else
          $.ajax
            url: '/notifications/'+id,
            type: 'PUT',
            data: notification,
            success: ( response ) ->
              window.reloadView()
          $( this ).dialog( "close" )
      Cancel: ()->
        $( this ).dialog( "close" )
  $('#assign_payload').dialog
    autoOpen: false,
    show: "blind",
    hide: "explode"
    modal: true
    buttons:
      'Ok': ()->
        console.log "OK"
        $.ajax
          url: window.payload_post_url
          type: 'POST',
          success: ( response ) ->
            console.log(response)
            window.location.reload()
            $('#assign_payload').dialog( "close" )
            window.reloadView()
      'Cancel': ()->
        console.log "close"
        $( this ).dialog( "close" )

  $('#view_booboo').dialog
    autoOpen: false,
    show: "blind",
    hide: "explode"
    width: 750
    buttons:
      Ok: ()->
        $( this ).dialog( "close" )
      Cancel: ()->
        $( this ).dialog( "close" )

  $('#assign_payload').dialog
    autoOpen: false,
    show: "blind",
    hide: "explode"
    modal: true
    buttons:
      'Ok': ()->
        console.log "OK"
        $.ajax
          url: window.payload_post_url
          type: 'POST',
          success: ( response ) ->
            console.log(response)
            $('#assign_payload').dialog( "close" )
            window.reloadView()
      'Cancel': ()->
        console.log "close"
        $( this ).dialog( "close" )
        ###
window.initialize_client_manager = ()->
  jobs_template    = Handlebars.compile($("#jobs-template").html()) 
  booboos_template = Handlebars.compile($("#booboos-template").html())
  window.spinner = new Spinner(opts)

  $('a[data-toggle="tab"]').on 'show.bs.tab', (e)-> 
    window.spinner.spin document.getElementById( 'preview' )

  $('a[data-toggle="tab"]').on 'shown.bs.tab', (e)-> 
    target = $(e.target)
    $.getJSON target.attr('data-path'), (data)-> 
      target_id = target.attr('href')

      template = jobs_template    if target_id in ["#pending", "#failed", "#succeeded", "#latest"]
      template = booboos_template if target_id == "#errors"

      $(target_id).html( template(data) ) 
      registerHooks()
      window.spinner.stop document.getElementById( 'preview' )

  $('.chosen').chosen().change () -> 
    id = $(this).val()
    window.location.href = "/client_manager?business_id=#{id}"

  $('a[data-toggle="tab"]').first().click()

  $('#refresh').click (e) -> 
    window.spinner.spin document.getElementById( 'preview' )
    $('li.active > a').trigger('shown.bs.tab')


opts = 
  lines: 13 # The number of lines to draw
  length: 20#// The length of each line
  width: 10#// The line thickness
  radius: 30#// The radius of the inner circle
  corners: 1#// Corner roundness (0..1)
  rotate: 0#// The rotation offset
  direction: 1#// 1: clockwise#-1: counterclockwise
  color: '#000'#// #rgb or #rrggbb or array of colors
  speed: 1#// Rounds per second
  trail: 60#// Afterglow percentage
  shadow: false#// Whether to render a shadow
  hwaccel: false#// Whether to use hardware acceleration
  className: 'spinner'#// The CSS class to assign to the spinner
  zIndex: 2e9#// The z-index (defaults to 2000000000)
  top: 'auto'#// Top position relative to parent in px
  left: 'auto' #// Left position relative to parent in px