# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#= require demo
#= require form/listing_finder
#= require form/business_details
#= require form/payment_methods
#= require form/business_hours
#= require form/mail_settings
#= require form/existing_account_logins
#= require form/categories

$(document).ready ->
  $('input[rel=popover]').popover()
