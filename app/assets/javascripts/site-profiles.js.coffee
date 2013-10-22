$ ->
  $('input[name=site_profile\\[enabled_for_scan\\]]').change () -> 
    $(this).closest("form").submit()

  $('.account_sync').click () -> 
    $(this).closest("form").submit()

  $('.enable_sync').on "ajax:success", (e, data, status, xhr) -> 
    dns = xhr.responseJSON.do_not_sync 
    $(this).find("input[name=client_data\\[do_not_sync\\]]").val( !dns )
    if dns
      $(this).find(".sync_enabled").hide()
      $(this).find(".sync_disabled").show()
    else
      $(this).find(".sync_disabled").hide()
      $(this).find(".sync_enabled").show()
