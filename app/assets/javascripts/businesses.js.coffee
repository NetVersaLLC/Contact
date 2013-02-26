# Business form

#= require jquery.optionTree
#= require form/listing_finder
#= require form/business_details
#= require form/payment_methods
#= require form/business_hours
#= require form/categories
#= require form/uploader

$(document).ready ->
  $('input[rel=popover]').popover
    trigger: 'hover'

root = exports ? this
root.save_stages = ->
  $.ajax
    type: "POST"
    cache: false
    dataType: "json"
    url: "/save_state"
    data: $('form.business').serialize()
    success: (data) ->
      alert data
