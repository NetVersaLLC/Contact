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
    dataType: "html"
    url: $('form.business').attr('action'),
    data: $('form.business').serialize()
    success: (data) ->
      if g_idx<4
        $('form.business').html data
        fn_deactivate_all_tabs()
        fn_activate_tab g_idx+1
        $(".form-tabs li").removeClass "active"
        $(".form-tabs li:eq("+(g_idx+1)+")").addClass "active"
        $("div.tab-pane").removeClass "active"
        $("#tab"+(g_idx+2)).addClass "active"
        window.g_idx++
      

window.g_idx = 0
$ ->
  window.fn_deactivate_all_tabs = ->
    $(".tab-content *").prop "disabled", true

  window.fn_activate_tab = (idx) ->
    $(".tab-content #tab" + (idx + 1) + " *").prop "disabled", false

  window.fn_business_ajax_form_init = ->
    $(".form-tabs li").click ->
      window.g_idx = $(this).index()
      fn_deactivate_all_tabs()
      fn_activate_tab window.g_idx
    $("form.business").unbind().submit ->
      save_stages()
      false




  fn_deactivate_all_tabs()
  fn_activate_tab 0

  $.ajaxSetup
    beforeSend: ->
      $(".ajax-progress").show()
    complete: ->
      $(".ajax-progress").hide()







