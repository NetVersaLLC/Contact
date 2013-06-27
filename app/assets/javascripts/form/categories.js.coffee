window.categories = ->
  $('.business-category').autocomplete
    source: (req, add)->
      $.getJSON "/google_categories/"+ req.term, (data)->
        add(data)
        $('form').resetClientSideValidations();
    change: (event, ui)-> 
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
    existing.push this.value


show_category_alert = (message, inputElement) -> 
  $("#section8").prepend("<div class='alert alert-danger'>#{message}</div>") 
  inputElement.value = ""
  setTimeout( clear_category_alert, 5000) 

clear_category_alert = -> 
  $("#section8").find("div.alert-danger").remove() 

$(document).ready ->
  window.categories()
