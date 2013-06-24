
$ ->
  $('#start_call').click () -> 
    $(this).attr('disabled','disabled') 
    create_phone_verification_job()

create_phone_verification_job = () ->
  $.post "/jobs.json", 
    $('#phone_verification_job_data').serialize() 
  $('#code-step-1').hide() 
  $('#code-step-2').show()
  poll_for_code()
 
poll_for_code =  () -> 
  return if $('#verification-code').length == 0 

  $.ajax 
    type: "GET" 
    url: "/codes/#{window.codes_business_id}/#{window.codes_site_name}.json" 
    success: (data, status, response) -> 
      $('#verification-code').text( data.code ) 
    error: () -> 
      window.setTimeout poll_for_code, 1000
