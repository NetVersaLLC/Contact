
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

window.loadPayloadNodes = () ->
  $.getJSON '/payload_nodes.json', (data)->
    html =  '<ul id="payload_list_ul" data-payload-id="root" class="connect_thru"></ul>'
    html += '<h6>Trash-em</h6>'
    html += '<p>Drag and drop below to remove a node.</p>'
    html += '<ul id="payload_list_trash" data-payload-id="trash" class="connect_thru trashem"></ul>' 
    html += '<input id="new_node_name"/>'
    html += '<button id="add_payload_node">New Node</button>'
    html += '<button id="save_payload_nodes">Save</button>'
    $('#payload_nodes_container').html(html)

    $.each data, (i,e)->
      console.log e 
      html =  "<li data-payload-id='#{e.id}' data-payload-name='#{e.name}' >"
      html += e.name
      html += "<ul data-payload-id='#{e.id}'></ul>" # this allows an item to be nested
      html += '</li>'
      parent_id = if e.parent_id? then e.parent_id else 'root'
      $("ul[data-payload-id=#{parent_id}]").append(html)

    $('#payload_nodes_container ul, #payload_trash').sortable({connectWith: '#payload_nodes_container ul, .connect_thru'})
    $('#add_payload_node').click (e) -> 
      node_name = $('#new_node_name').val()
      now = new Date() 
      new_id = "new_#{now.getTime()}"
      $('#payload_list_ul').append("<li data-payload-id='#{new_id}' data-payload-name='#{node_name}'>#{node_name}<ul data-payload-id='#{new_id}'> </ul></li>")
      $('#payload_nodes_container ul, #payload_trash').sortable({connectWith: '#payload_nodes_container ul, .connect_thru'})

    $('#save_payload_nodes').click (e) -> 
      payload = {} 
      payload.tree = [] 
      payload.trash = []
      $('#payload_list_ul li').each (i,e)-> 
        payload_id = $(e).attr( 'data-payload-id')
        payload_name = $(e).attr( 'data-payload-name' )
        payload_parent_id =  $(e).parent().attr( 'data-payload-id')
        payload.tree.push( {id: payload_id, parent_id: payload_parent_id, name: payload_name})
      $('#payload_list_trash li').each (i,e)-> 
        payload_id = $(e).attr( 'data-payload-id')
        payload.trash.push( {id: $(e).attr('data-payload-id') } )
      console.log payload
      request = $.ajax 
        type: "POST" 
        url:  '/payload_nodes.json'
        data: payload 
      request.done (data) -> 
        alert('Payload updated.') 
        window.loadPayloadsNodes()
      request.fail () -> alert('Payload update failed.')


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
