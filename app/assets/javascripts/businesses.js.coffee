# Business form

#= require demo
#= require form/listing_finder
#= require form/business_details
#= require form/payment_methods
#= require form/business_hours
## require form/mail_settings
#= require form/existing_account_logins
#= require form/categories

$(document).ready ->
  $('input[rel=popover]').popover()

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
