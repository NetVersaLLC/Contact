registerHooks = ()->
  $('.delete_job').click (e)->
    window.job_id = $(e.target).parent().attr('data-job-id')
    console.log window.job_id
    $('#delete_job').dialog( "open" )
  $('.view_payload').click (e)->
    window.job_id = $(e.target).parent().attr('data-job-id')
    console.log window.job_id
    $('#view_payload').html('<iframe src="/admin/jobs/'+window.job_id+'/view_payload?table='+window.current_tab+'" style="width: 700px; height: 300px" scrolling="yes" marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0">')
    $('#view_payload').dialog( "open" )
  $('.view_meta').click (e)->
    window.job_id = $(e.target).parent().attr('data-job-id')
    console.log window.job_id
    $.get '/admin/jobs/'+window.job_id+'/view_meta.js', { table: window.current_tab }, (data)->
      $('#view_meta').dialog({autoOpen: false}) 
      $('#view_meta').html(data)
      $('#view_meta').dialog( "open" )
  $('.view_backtrace').click (e)->
    window.job_id = $(e.target).parent().attr('data-job-id')
    console.log window.job_id
    $('#view_backtrace').html('<iframe src="/admin/jobs/'+window.job_id+'/view_backtrace" style="width: 700px; height: 300px" scrolling="yes" marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0">')
    $('#view_backtrace').dialog( "open")
  $('.view_screenshot').click (e)->
    window.location.href = $(e.target).attr('data-screenshot-url')
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
  $('.rerun').click (e)->
    window.job_id = $(e.target).parent().attr('data-job-id')
    console.log window.job_id
    $('#rerun_payload').dialog( "open" )
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
  $('#client_tabs').tabs
    select: (event,ui)->
      func = actions[ ui.index ]
      window.reloadView = () ->
        func( ui.panel )
      func( ui.panel )
  # Setup the reload button
  window.reloadView = () ->
    showPending( $('#client_tabs-1' ) )
  $('#reloadButton').click ->
    window.reloadView()
  window.reloadView()
  # Respond to panel clicks
  $('#delete_job').dialog
    autoOpen: false,
    show: "blind",
    hide: "explode"
    buttons:
      "Ok": ->
        $.ajax
          url: '/admin/jobs/'+window.job_id+'/delete_job.js',
          type: 'DELETE',
          success: ( response ) ->
            $('#delete_job').dialog( "close" )
            window.reloadView()
      "Cancel": ()->
        $( this ).dialog( "close" )
  $('#view_payload').dialog
    autoOpen: false,
    show: "blind",
    hide: "explode"
    width: 750
    buttons:
      Ok: ()->
        $( this ).dialog( "close" )
      Cancel: ()->
        $( this ).dialog( "close" )

  $('#view_backtrace').dialog
    autoOpen: false,
    show: "blind",
    hide: "explode"
    width: 750
    buttons:
      Ok: ()->
        $( this ).dialog( "close" )
      Cancel: ()->
        $( this ).dialog( "close" )

  $('#rerun_payload').dialog
    autoOpen: false,
    show: "blind",
    hide: "explode"
    width: 750
    buttons:
      Ok: ()->
        $.ajax
          url: '/admin/jobs/'+window.job_id+'/rerun_job.js',
          type: 'PUT',
          success: ( response ) ->
            $('#rerun_payload').dialog( "close" )
            window.reloadView()
      Cancel: ()->
        $( this ).dialog( "close" )

  $('#view_meta').dialog
    autoOpen: false,
    show: "blind",
    hide: "explode"
    width: 500
    buttons:
      Ok: ()->
        obj = {}
        obj['table']          = window.current_tab
        obj['name']           = $('#job_name').val()
        obj['data_generator'] = $('#job_data_generator').val()
        obj['status']         = $('#job_status').val()
        obj['status_message'] = $('#job_status_message').val()
        obj['position']       = $('#job_position').val()
        if $('#job_wait').is(':checked')
          obj['wait']         = true
        else
          obj['wait']         = false
        $.ajax
          url: '/admin/jobs/'+window.job_id+'/update_job.js?'+$.param(obj),
          type: 'PUT',
          success: ( response ) ->
            window.reloadView()
        $( this ).dialog( "close" )
      Cancel: ()->
        $( this ).dialog( "close" )

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

window.initialize_client_manager = ()->
  jobs_template    = Handlebars.compile($("#jobs-template").html()) 
  booboos_template = Handlebars.compile($("#booboos-template").html())

  $('a[data-toggle="tab"]').on 'shown.bs.tab', (e)-> 
    target = $(e.target)
    $.getJSON target.attr('data-path'), (data)-> 
      target_id = target.attr('href')

      template = jobs_template    if target_id in ["#pending", "#failed", "#succeeded", "#latest"]
      template = booboos_template if target_id == "#errors"

      $(target_id).html( template(data) ) 


