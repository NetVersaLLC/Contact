$ ->
  $('input[name=site_profile\\[enabled_for_scan\\]]').change () -> 
    console.log 'changed'
    $(this).closest("form").submit()
