
$ ->
  if $('#code-step-1').length > 0 
    $('#start_call').click () -> 
      #$(this).attr('disabled','disabled') 
      create_phone_verification_job()

create_phone_verification_job = () ->
  console.log 'create job' 
  $.post "/jobs.json", 
    $('#phone_verification_job_data').serialize() 
  $('#code-step-1').hide() 
  $('#code-step-2').show()
