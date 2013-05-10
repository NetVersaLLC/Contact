window.loadPayloadList = ()->
  console.log $('#packages_list').val()
  $.getJSON '/packages/' + $('#packages_list').val() + '.json', (data)->
    html = '<tbody>'
    $.each data, (i,e)->
      row_class = if i % 2 == 0 then 'even' else 'odd' 
      html += "<tr class='#{row_class}'>"
      html += '<td class="payload_name">'+e['site']+'/'+e['payload']+'</td>'
      html += '<td><a class="payload_delete" data-package-id="'+e['id']+'" href="#">Delete</a></td>'
      html += '</tr>'
    html += '</tbody>'
    $('#package_content_table').html(html)
    $('.payload_delete').click (e)->
      $.ajax
        url: '/packages/'+$(e.target).attr('data-package-id')+'.js',
        type: 'DELETE',
        success: ( response ) ->
          console.log(response)
          #window.location.reload()
          window.loadPayloadList()

window.packagePayloadListAction = (e)->
  console.log "payloadListAction()"
  window.assign_payload = $(e.target).attr('data-payload-id')
  window.payload_post_url = "/packages/#{$('#packages_list').val()}.json?payload_id=#{window.assign_payload}&category=#{$('#payload_categories_select').val()}"
  $('#assign_payload').dialog("open")

$(document).ready ()->
  # $('#label_form_xyzzy').append('<input type="hidden" name="authenticity_token" value="'+$('meta[name="csrf-token"]').attr('content')+'" />')
  if window.location.href.indexOf('package_contents') >  0 
    window.loadPayloadList()
    window.startPayloads()
    window.reloadView = () -> 
      window.loadPayloadList() 
  $('#packages_list').change (e)->
    window.loadPayloadList()

