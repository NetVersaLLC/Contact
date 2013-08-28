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
      $('#payload_list_ul').append("<li data-payload-id='new' data-payload-name='#{node_name}'>#{node_name}<ul></ul></li>")

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
        window.loadPayloads()
      request.fail () -> alert('Payload update failed.')

