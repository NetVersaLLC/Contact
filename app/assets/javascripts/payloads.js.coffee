payloadsShow = (api, item)->
  parent_id = api.getId(item)
  $.getJSON "/payloads/"+api.getId(item)+".json", (data)->
    $('input[name="payload[name]"]').val( data['name'] )
    if data['active'] == true
      $('input[name="payload[active]"]').prop('checked', true)
    else
      $('input[name="payload[active]"]').prop('checked', false)
    $('#payloads_parent_id').val( parent_id )

initializeAciTree = ()->
  $('#payloads_tree').aciTree
    sortable: true,
    ajax:
      url: '/empty.json#'
  $('#payloads_tree').on 'acitree', (event, api, item, eventName, options)->
    if eventName == 'sorted'
      parent = api.parent(item)
      $.ajax
        url: "/payloads/move/"+api.getId(item)+"/"+api.getId(parent)+".json"
        type: "PUT"
    else if eventName == 'selected'
      $('#payloads_status').html( "Site: "+window.payloads_site+" Payload: "+api.getLabel(item))
      window.payloads_id = api.getId(item)
      payloadsShow(api, item)

payloadsLoad = ->
  site_id = $('#payloads_site').val()
  mode_id = $('#payloads_mode').val()
  $('#payloads_site_id').val(site_id)
  $('#payloads_mode_id').val(mode_id)
  window.payloads_site = $("#payloads_site option:selected").text()
  $('#payloads_status').html( "Site: "+window.payloads_site )
  $.getJSON "/payloads/tree/"+site_id+"/"+mode_id+".json", (data)->
    api = $('#payloads_tree').aciTree('api')
    options = {
      unanimated: true
    }
    api.unload(null, options)
    options = {
      itemData: data
    }
    api.loadFrom(null, options)

payloadsDelete = ()->
  api = $('#payloads_tree').aciTree('api')
  item = api.selected()
  if confirm("Are you sure you want to destroy "+api.getLabel(item)+" and all it's children?") == true
    api.remove(item)
    $.ajax
      url: "/payloads/"+api.getId(item)+".json"
      type: "DELETE"

payloadsUpdateTree = (data)->
  console.log("Starting updateTree!")
  api = $('#payloads_tree').aciTree('api')
  current = api.selected()
  options =
    success: (item, options)->
      console.log("Added: ", item, options)
    fail: (item, options)->
      console.log("Failed!", item, options)
    itemData:
      id: data['id'],
      label: data['name']
      isFolder: true
  window.hinkerdink_current = current
  window.hinkerdink_options = options
  api.append(current, options)

payloadsCreate = ()->
  api = $('#payloads_tree').aciTree('api')
  current = api.selected()
  return unless current
  $.ajax
    url: "/payloads.json"
    type: "POST"
    dataType: 'json'
    data: $('#payloads_form').serialize()
    success: (data)->
      console.log("was here: ", data)
      payloadsUpdateTree(data)

payloadsUpdate = ()->
  return unless window.payloads_id
  api = $('#payloads_tree').aciTree('api')
  $.ajax
    url: "/payloads/"+window.payloads_id+".json"
    type: "PUT"
    data: $('#payloads_form').serialize()

$ ->
  initializeAciTree()
  $('#payloads_site').change payloadsLoad
  $('#payloads_mode').change payloadsLoad
  $('#payloads_delete').click payloadsDelete
  $('#payloads_create').click payloadsCreate
  $('#payloads_update').click payloadsUpdate

# payloadDataToList = (data)->
#  html = '<ol class="dd-list">'
#  if data.length > 0
#    $.each data, (i,e)->
#      html += '<li class="dd-item" data-id="'+e[1]+'">'
#      html += '<div class="dd-handle">'+e[0]+'</div>'
#      if e.length > 2 and e[2].length > 0
#        html += payloadDataToList(e[2])
#      html += '</li>'
#  html += '</ol>'
#  html

