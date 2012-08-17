window.buildSocial = (names)->
  console.log "Got: ", names
  html = ''
  $.each names, (i,e) ->
    html += '<div style="display: none" id="'+e[1]+'_fields_blueprint">'
    html += '<div class="well">'
    html += '<fieldset class="inputs">'
    html += '<legend>'+e[0]+'</legend>'
    html += '<div class="fields">'
    $.each e[2], (j,f) ->
      html += '<div class="control-group">'
      html += '<label class="control-label" for="business['+e[1]+'_attributes][new_'+[1]+']['+f[1]+']">'+f[1]+'</label>'
      html += '<div class="controls">'
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

# HACK HACK HACK
# Removal of button is called before the callbacks that add the
# form element. So... delay the remove of the button by one second.
window.removeButton = (obj)->
  calFun = ()->
    $(obj).remove()
  setTimeout(calFun, 1000)

$(document).ready ->
  window.buildSocial(window.socialAccounts)
