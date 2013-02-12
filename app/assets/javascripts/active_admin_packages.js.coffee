window.loadPayloadList = ()->
  console.log $('#packages_list').val()
  $.getJSON '/admin/jobs/' + $('#packages_list').val() + '/showass.json', (data)->
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
  window.payload_post_url = "/admin/jobs/#{$('#packages_list').val()}/assload.js?payload_id=#{window.assign_payload}&category=#{$('#payload_categories_select').val()}"
  $('#assign_payload').dialog("open")

$(document).ready ()->
  $('#label_form_xyzzy').append('<input type="hidden" name="authenticity_token" value="'+$('meta[name="csrf-token"]').attr('content')+'" />')
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
