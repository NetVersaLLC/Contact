payloadsLoad = ->
  site_id = $('#payloads_site').val()
  mode_id = $('#payloads_mode').val()
  console.log("site_id: "+site_id)
  console.log("mode_id: "+mode_id)
  $.getJSON "/payloads/"+site_id+"/"+mode_id+".json", (data)->
    console.log(data)

$ ->
  $('#payloads_site').change ->
    payloadsLoad()
  $('#payloads_mode').change ->
    payloadsLoad()
  $('#payloads_load').click ->
    payloadsLoad()
