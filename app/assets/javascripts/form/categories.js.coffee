window.categories = ->
  $('.business-category').autocomplete
    source: (req, add)->
      $.getJSON "/google_categories/"+req.term, (data)->
        add(data)
        $('form').resetClientSideValidations();
    change: (event, ui)-> 
      target = event.currentTarget
      # these fields do not have to containg an entry (blank is ok)
      if (target.id == 'business_category4' ||  target.id == 'business_category5') && not target.value?.length 
        return
      if (target.id == 'business_category1')
        $('form').append('<input type="hidden" name="categorized" value="false" />')
      if (ui.item == null)  # was not selected from the list 
        show_category_alert("You must select an item from the list.", event.currentTarget) 
      check_for_duplicates( event.currentTarget ) 

check_for_duplicates = (inputElement) -> 
  return if not inputElement.value?.length 
  existing = []
  $('.business-category').each () -> 
    if existing.indexOf( this.value ) >= 0 
      show_category_alert "You are not allowed to have duplicate category entries", inputElement 
      return false
    existing.push this.value if this.value?.length


show_category_alert = (message, inputElement) -> 
  console.log inputElement
  required = ['business_category1']
  if required.indexOf( inputElement.id ) >= 0
    $(inputElement).closest('.control-group').addClass('error')
  $("#section8").prepend("<div class='alert alert-danger'>#{message}</div>") 
  inputElement.value = ""
  setTimeout( clear_category_alert, 5000) 

clear_category_alert = -> 
  $("#section8").find("div.alert-danger").remove() 

$(document).ready ->
  window.categories()
