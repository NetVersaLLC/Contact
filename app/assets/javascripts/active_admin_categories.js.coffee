findTier = (arr, id)->
  if parseInt(arr[1]) == parseInt(id)
    return arr
  if arr.length > 2
    found = null
    $.each arr[2], (i,e)->
      retVal = findTier(e, id)
      if retVal != null
        found = retVal
    if found != null
      return found
  return null

setSelection = (model, tier)->
  $('#title_'+model).html( tier[0] )
  $('#'+model).val( tier[1] )

window.subCategory = (select)->
  val   = $(select).val()
  model = $(select).attr('data-model')
  arr   = eval "window."+model
  tier  = findTier(arr, val)
  div   = $(select).next()
  if tier.length < 3
    setSelection(model, tier)
    return
  html = '<select class="aSelect" onchange="window.subCategory(this)" data-model="'+model+'">'
  $.each tier[2], (i,e)->
    html += '<option value="'+e[1]+'">'+e[0]+'</option>'
  html += '</select><div class="nextCategory"></div>'
  div.html(html)

window.firstCategory = (select)->
  model = $(select).attr('data-model')
  arr   = eval "window."+model
  setSelection(model, arr[2])
  window.subCategory(select)

window.loadCategory = (model)->
  arr = eval "window."+model
  $('#title_'+model).html('')
  html = '<select class="topSelect" onchange="window.subCategory(this)" data-model="'+model+'">'
  $.each arr, (j,e) ->
    if j == 0
      return
    $.each e, (i, em)->
      html += '<option value="'+em[1]+'">'+em[0]+'</option>'
  html += '</select><div class="nextCategory"></div>'
  $('#selector_'+model).html(html)

$(document).ready ()->
  $('#categoryForm').append('<input type="hidden" name="authenticity_token" value="'+$('meta[name="csrf-token"]').attr('content')+'" />')
  $('#show_allcategories').click ()->
    $('input[type="button"]').click()
  $('.selectormatic').click ()->
   console.log($(this).attr('data-model') )
