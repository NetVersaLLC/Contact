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

window.currentSection = 0

window.gotoSection = (section)->
  $.each [0, 1,2,3,4,5,6,7,8,9,10], (i,e) ->
    if e != window.currentSection
      $('#section'+e).hide()
    else
      $('#section'+e).show()

$(document).ready ->
  $('input[rel=popover]').popover()
  # $.each [1,2,3,4,5,6,7,8,9,10], (i,e) ->
  #   $('#section'+e).hide()
  # $('#next_section').click (e)->
  #   window.currentSection += 1 if window.currentSection < 10
  #   window.gotoSection(window.currentSection)
  # $('#prev_section').click (e)->
  #   window.currentSection -= 1 if window.currentSection > 0
  #   window.gotoSection(window.currentSection)
