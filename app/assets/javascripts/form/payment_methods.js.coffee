$(document).ready ->
  $('.acceptrow').click (e)->
    if $(e.target).hasClass('checkbox')
      wrapper = $(e.target).closest('.acceptrow')
      checkbox = wrapper.find('input:checkbox')
      if checkbox.is(':checked')
        checkbox.attr('checked', false)
      else
        checkbox.attr('checked', true)
