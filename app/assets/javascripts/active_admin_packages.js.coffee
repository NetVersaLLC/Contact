window.loadPayloadList = ()->
  console.log $('#packages_list').val()

window.packagePayloadListAction = (e)->
  console.log "payloadListAction()"
  window.assign_payload = $(e.target).attr('data-payload-id')
  window.payload_post_url = "/admin/jobs/#{$('#packages_list').val()}/assload.js?payload_id=#{window.assign_payload}&category=#{$('#payload_categories_select').val()}"
  $('#assign_payload').dialog("open")

$(document).ready ()->
  window.payloadListAction = window.packagePayloadListAction
  window.loadPayloadList()
  window.startPayloads()
  $('#packages_list').change (e)->
    window.loadPayloadList()
  $('.payload_delete').click (e)->
    $.ajax
      url: '/admin/jobs/'+$(e.target).attr('data-package-id')+'/removeass.js',
      type: 'DELETE',
      success: ( response ) ->
        console.log(response)
        window.location.reload()
