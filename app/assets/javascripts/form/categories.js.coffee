window.categories = ->
  $('#business_category1').autocomplete
    source: (req, add)->
      $.getJSON "/google_categories/"+$('#business_category1').val(), req, (data)->
        add(data)
        $('form').resetClientSideValidations();
  $('#business_category2').autocomplete
    source: (req, add)->
      $.getJSON "/google_categories/"+$('#business_category2').val(), req, (data)->
        add(data)
        $('form').resetClientSideValidations();
  $('#business_category3').autocomplete
    source: (req, add)->
      $.getJSON "/google_categories/"+$('#business_category3').val(), req, (data)->
        add(data)
        $('form').resetClientSideValidations();
  $('#business_category4').autocomplete
    source: (req, add)->
      $.getJSON "/google_categories/"+$('#business_category4').val(), req, (data)->
        add(data)
  $('#business_category5').autocomplete
    source: (req, add)->
      $.getJSON "/google_categories/"+$('#business_category5').val(), req, (data)->
        add(data)

$(document).ready ->
  window.categories()
