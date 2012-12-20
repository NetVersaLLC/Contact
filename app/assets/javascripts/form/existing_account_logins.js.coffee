window.togglePasswordField = (button)->
  el = $(button).prev()
  el = el[0]
  if el.type == 'password'
    el.type = 'text'
  else
    el.type = 'password'

window.addSocial = (name)->
  console.log "Got: ", name
  html = ''
  e = window.socialAccounts[name]
  html += '<div id="'+e[1]+'_fields_blueprint">'
  html += '<div class="well">'
  html += '<fieldset class="inputs">'
  html += '<legend>'+e[0]+'</legend>'
  html += '<div class="fields">'
  $.each e[2], (j,f) ->
    html += '<div class="control-group">'
    html += '<label class="control-label" for="business['+e[1]+'_attributes][new_'+[1]+']['+f[1]+']">'+f[1]+'</label>'
    html += '<div class="controls">'
    if f[0] == 'text' and f[1] == 'password'
      html += '<input type="password" size="30" name="business['+e[1]+'_attributes][new_'+e[1]+']['+f[1]+']" id="business_'+e[1]+'_attributes_new_'+e[1]+'_'+f[1]+'">'
      html += '<input class="btn btn-info" type="button" value="Show" onclick="window.togglePasswordField(this)" />'
    else
      html += '<input type="'+f[0]+'" size="30" name="business['+e[1]+'_attributes][new_'+e[1]+']['+f[1]+']" id="business_'+e[1]+'_attributes_new_'+e[1]+'_'+f[1]+'">'
    html += '</div>'
    html += '</div>'
  html += '<input type="hidden" value="false" name="business['+e[1]+'_attributes][new_'+e[1]+'][_destroy]" id="business_'+e[1]+'_attributes_new_'+e[1]+'__destroy">'
  html += '<a href="javascript:void(0)" class="remove_nested_fields">Remove '+e[0]+'</a>'
  html += '<br />'
  html += '</fieldset>'
  html += '</div>'
  html += '</div>'
  $('#socialmedia').append( html )
  $("#add_accounts option[value='"+name+"']").remove();

window.clearCategory = (em)->
  div = em.parentNode
  console.log div
  input = div.previousSibling.previousSibling
  console.log input
  div.parentNode.removeChild(div)
  id = $(input).attr('id')
  name = $(input).attr('name')
  parts = name.match(/business\[[^\]]+\]\[0\]\[(.*?)_id\]/)
  source = parts[1]
  value  = $(input).attr('value')
  console.log("Fetching: ", source)
  $.getJSON "/"+source+".json", (data)->
    $('#'+id).optionTree( data )



$(document).ready ->
  $('.load_categories').each (i,e)->
    id = $(e).attr('id')
    name = $(e).attr('name')
    parts = name.match(/business\[[^\]]+\]\[0\]\[(.*?)_id\]/)
    source = parts[1]
    value  = $(e).attr('value')
    console.log("Fetching: ", source)
    if value == ''
      $.getJSON "/"+source+".json", (data)->
        $('#'+id).optionTree( data )


  $('#add_account_button').click (e) ->
    e.preventDefault()
    key = $('#add_accounts').val()
    window.addSocial(key)
