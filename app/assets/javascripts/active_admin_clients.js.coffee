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
  $.getJSON "/admin/jobs/pending_jobs.js?business_id=#{window.business_id}", (data)->
    $(panel).html( window.buildTable(data) )
    registerHooks()
showClient = (panel)->
  window.current_tab = "ciients"
  console.log "Client", panel
window.loadPayloads = (em)->
  $.getJSON '/admin/payloads/'+$(em).val()+'/list.js', (data)->
    console.log data
    html = '<ul id="payload_list_ul">'
    $.each data, (i,e)->
      html += '<li data-payload-id="'+e['id']+'">'+e['name']+'</li>'
    html += '</ul>'
    $('#payload_list_container').html(html)
    $('#payload_list_ul > li').click (e)->
      window.assign_payload = $(e.target).attr('data-payload-id')
      $('#assign_payload').dialog( "open" )

$(document).ready ->
  # Setup Payload Categories
  $.getJSON '/admin/payload_categories/list.js', (data)->
    html = '<select id="payload_categories" onchange="window.loadPayloads(this);">'
    $.each data, (i,e)->
      html += '<option value="'+e['id']+'">'+e['name']+'</option>'
    html += '</select><div id="payload_list_container"></div>'
    $('#payload_list').html(html)
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

