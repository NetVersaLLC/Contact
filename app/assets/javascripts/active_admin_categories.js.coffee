
setSelection = (model, tier)->
  $('#title_'+model).html( tier[0] )
  $('#'+model.toLowerCase()).val( tier[1] )

add_option = (category, element, depth) -> 
  opt = document.createElement("Option")
  opt.value = category[1]
  opt.text = category[0]
  element.appendChild(opt) 

  if category.length == 3 
    opt.text = depth + category[0]
    opt.disabled = true
    add_options( category[2], element, depth + category[0].substr(0,5) + " > ")




add_options = (categories, element, depth) -> 
  options = (add_option(category, element, depth) for category in categories)

window.loadCategory = (model)->
  categories = eval "window."+model
  return unless categories.length == 3 

  $('#title_'+model).html('')
  select = document.getElementById(model.toLowerCase())
  add_options(categories[2], select, '')


$(document).ready ()->
  $('#categoryForm').append('<input type="hidden" name="authenticity_token" value="'+$('meta[name="csrf-token"]').attr('content')+'" />')
  $('#show_allcategories').click ()->
    $('input[type="button"]').click()
  $('.selectormatic').click ()->
   console.log($(this).attr('data-model') )
