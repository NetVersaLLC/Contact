window.loadPayloadList = ()->
  console.log $('#packages_list').val()
  $.getJSON '/packages/' + $('#packages_list').val() + '.json', (data)->
    html = '<tbody>'
    $.each data, (i,e)->
      html += '<tr>'
      html += '<td class="payload_name">'+e['site']+'/'+e['payload']+'</td>'
      html += '<td class="payload_delete" data-package-id="'+e['id']+'">Delete</td>'
      html += '</tr>'
    html += '</tbody>'
    $('#package_content_table').html(html)

window.packagePayloadListAction = (e)->
  console.log "payloadListAction()"
  window.assign_payload = $(e.target).attr('data-payload-id')
  window.payload_post_url = "/packages/#{$('#packages_list').val()}.json?payload_id=#{window.assign_payload}&category=#{$('#payload_categories_select').val()}"
  $('#assign_payload').dialog("open")

$(document).ready ()->
  # $('#label_form_xyzzy').append('<input type="hidden" name="authenticity_token" value="'+$('meta[name="csrf-token"]').attr('content')+'" />')
  window.payloadListAction = window.packagePayloadListAction
  match = window.location.href.match(/package_contents/)
  if match != null and match.length > 0
    window.loadPayloadList()
    window.startPayloads()
  $('#packages_list').change (e)->
    window.loadPayloadList()
  $('.payload_delete').click (e)->
    $.ajax
      url: '/packages/'+$(e.target).attr('data-package-id')+'.js',
      type: 'DELETE',
      success: ( response ) ->
        console.log(response)
        window.location.reload()
