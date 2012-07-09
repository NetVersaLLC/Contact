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
    $.getJSON('/admin/jobs/'+window.job_id+'/view_meta.js', (data)->
      $('#view_meta').html(data['html'])
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

$(document).ready ->
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
        $( this ).dialog( "close" )
      Cancel: ()->
        $( this ).dialog( "close" )
