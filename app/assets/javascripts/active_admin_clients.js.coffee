window.buildTable = (data) ->
  html = '<ul class="displayList">'
  $.each data, (i,e)->
    color = 'info'
    switch(e['status'])
      when 0
        color = 'ui-icon-mail-closed info'
      when 1
        color = 'ui-icon-mail-open warning'
      when 4
        color = 'ui-icon-circle-check success'
      when 5
        color = 'ui-icon-alert failure'
    html += '<li class="ui-state-default ui-corner-all" data-job-id="'+e['id']+'">'
    html += e['name']+' '
    html += '<span title="'+e['status_message']+'"'
    html += 'class="ui-icon '+color+'">'
    html += '</span>'
    html += '<span class="ui-icon ui-icon-trash delete_job" title="Delete Job"></span>'
    html += '<span class="ui-icon ui-icon-script view_payload" title="View Payload"></span>'
    html += '<span class="ui-icon ui-icon-tag view_meta" title="View Meta"></span>'
    html += '</li>'
  html

window.buildErrorTable = (data)->
  console.log data
  html = '<ul class="displayList">'
  $.each data, (i,e)->
    color = 'ui-icon-alert failure'
    html += '<li class="ui-state-default ui-corner-all view_booboo" data-booboo-id="'+e['id']+'">'
    html += e['message']+' '
    html += '<span class="ui-icon '+color+'"></span>'
    html += '</li>'
  html

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
      $('#view_meta').html(data)
      $('#view_meta').dialog( "open" )
  $('.view_booboo').click (e)->
    window.booboo_id = e.target.getAttribute('data-booboo-id')
    console.log window.booboo_id
    $.get '/admin/booboos/'+window.booboo_id+'/view.js', null, (data)->
      $('#view_booboo').html(data['message'])
      $('#view_booboo').dialog( "open" )
  $('.displayList').sortable
    stop: (event, ui) ->
      em = []
      $('.displayList > li').each (i,e)->
        em.push [i, $(e).attr('data-job-id')]
      console.log em
      $.post '/admin/jobs/'+window.business_id+'/reorder.js', { table: window.current_tab, order: JSON.stringify(em) }, (data)->
        console.log data

showPending = (panel)->
  window.current_tab = "jobs"
  $.getJSON "/admin/jobs/pending_jobs.js?business_id=#{window.business_id}", (data)->
    $(panel).html( window.buildTable(data) )
    registerHooks()
showFailed = (panel)->
  window.current_tab = "failed_jobs"
  $.getJSON "/admin/jobs/failed_jobs.js?business_id=#{window.business_id}", (data)->
    $(panel).html( window.buildTable(data) )
    registerHooks()
showCompleted = (panel)->
  window.current_tab = "completed_jobs"
  $.getJSON "/admin/jobs/completed_jobs.js?business_id=#{window.business_id}", (data)->
    $(panel).html( window.buildTable(data) )
    registerHooks()
showErrors = (panel)->
  window.current_tab = "booboos"
  $.getJSON "/admin/booboos/list.js?business_id=#{window.business_id}", (data)->
    $(panel).html( window.buildErrorTable(data) )
    registerHooks()
showClient = (panel)->
  window.current_tab = "ciients"
  console.log "Client", panel
  $.getJSON "/admin/businesses/#{window.business_id}/client_info.js", (data) ->
    html = '<table><tbody>'
    $.each data, (i,e)->
      html += '<tr>'
      html += '<td>'+i+'</td>'
      html += '<td>'+e+'</td>'
      html += '</tr>'
    html += '</tbody></table>'
    $(panel).html( html )

window.loadPayloads = ()->
  $.getJSON '/admin/payloads/'+$('#payload_categories_select').val()+'/list.js', (data)->
    html = '<ul id="payload_list_ul">'
    $.each data, (i,e)->
      html += '<li class="ui-state-default" data-payload-id="'+e['id']+'">'+e['name']+'</li>'
    html += '</ul>'
    $('#payload_list_container').html(html)
    $('#payload_list_ul > li').click (e)->
      window.assign_payload = $(e.target).attr('data-payload-id')
      $('#assign_payload').dialog( "open" )

window.startPayloads = () ->
  # Setup Payload Categories
  $.getJSON '/admin/payload_categories/list.js', (data)->
    html = '<select id="payload_categories_select" onchange="window.loadPayloads();">'
    $.each data, (i,e)->
      html += '<option value="'+e['id']+'">'+e['name']+'</option>'
    html += '</select><div id="payload_list_container"></div><br />'
    $('#payload_list').html(html)
    window.loadPayloads()
  # Setup Tabs
  actions = [
    showPending,
    showFailed,
    showCompleted,
    showErrors,
    showClient
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
      Ok: ()->
        $.ajax
          url: '/admin/jobs/'+window.job_id+'/delete_job.js',
          type: 'DELETE',
          success: ( response ) ->
            $('#delete_job').dialog( "close" )
            window.reloadView()
      Cancel: ()->
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
        obj['model']          = $('#job_model').val()
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
  
  $('#assign_payload').dialog
    autoOpen: false,
    show: "blind",
    hide: "explode"
    buttons:
      Ok: ()->
        $.ajax
          url: '/admin/jobs/'+window.assign_payload+'/create_job.js?business_id='+window.business_id,
          type: 'POST',
          success: ( response ) ->
            $('#assign_payload').dialog( "close" )
            window.reloadView()
      Cancel: ()->
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
