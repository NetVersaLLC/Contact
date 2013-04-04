# Business form

#= require jquery.optionTree
#= require form/listing_finder
#= require form/business_details
#= require form/payment_methods
#= require form/business_hours
#= require form/categories
#= require form/uploader


root = exports ? this
root.save_stages = ->
  $(".ajax-progress").show()
  $.ajax
    type: "POST"
    cache: false
    dataType: "html"
    url: $('form.business').attr('action'),
    data: $('form.business').serialize()
    success: (data, status, response) ->
      $(".ajax-progress").hide()
      if g_idx<4
        $('form.business').replaceWith data
        fn_deactivate_all_tabs()
        $(".form-tabs li").removeClass "active"
        $("div.tab-pane").removeClass "active"
        if response.status == 210
          fn_activate_tab g_idx
          $(".form-tabs li:eq("+(g_idx)+")").addClass "active"
          $("#tab"+(g_idx+1)).addClass "active"
          $('body').animate({'scrollTop':$('.error:first').offset().top-100})
        if response.status == 200
          fn_activate_tab g_idx+1
          $(".form-tabs li:eq("+(g_idx+1)+")").addClass "active"
          $("#tab"+(g_idx+2)).addClass "active"
          window.g_idx++
      else
        location.reload()

      

window.g_idx = 0
$ ->

  window.fn_deactivate_all_tabs = ->
    $(".tab-content *").prop "disabled", true

  window.fn_activate_tab = (idx) ->
    $(".tab-content #tab" + (idx + 1) + " *").prop "disabled", false
    setTimeout (->
      $('form.business').enableClientSideValidations();
    ), 300


  window.fn_business_ajax_form_init = ->
    $(".form-tabs li").click ->
      window.g_idx = $(this).index()
      fn_deactivate_all_tabs()
      fn_activate_tab window.g_idx
    $("form.business").unbind().submit ->
      save_stages()
      false
    $('input[rel=popover]').popover
      trigger: 'hover'
    window.initMap()




  fn_deactivate_all_tabs()
  fn_activate_tab 0

