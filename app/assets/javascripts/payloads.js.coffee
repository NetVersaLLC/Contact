payloadDataToList = (data)->
  html = '<ol class="dd-list">'
  if data.length > 0
    $.each data, (i,e)->
      html += '<li class="dd-item" data-id="'+e[1]+'">'
      html += '<div class="dd-handle">'+e[0]+'</div>'
      if e.length > 2 and e[2].length > 0
        html += payloadDataToList(e[2])
      html += '</li>'
  html += '</ol>'
  html

payloadsLoad = ->
  site_id = $('#payloads_site').val()
  mode_id = $('#payloads_mode').val()
  console.log("site_id: "+site_id)
  console.log("mode_id: "+mode_id)
  $.getJSON "/payloads/"+site_id+"/"+mode_id+".json", (data)->
    html = payloadDataToList(data)
    $('#payloads_tree').html( html )
    $('.dd').nestable()
    $('.dd-handle a').on 'mousedown', (e)->
      e.stopPropagation()
    $('[data-rel="tooltip"]').tooltip()

payloadsSave = ()->
  $.post("/payloads.json", data: $('.dd').nestable('serialize'))

$ ->
  $('#payloads_site').change ->
    payloadsLoad()
  $('#payloads_mode').change ->
    payloadsLoad()
  $('#payloads_load').click ->
    payloadsLoad()
  $('#payloads_save').click ->
    payloadsSave()
