$(document).ready ->
  $('#business_accounts_attributes_new_email').after('<button class="btn btn-info" onclick="window.detectEmailSettings();" id="detect_settings">Detect Email Settings</button>')
  $('#detect_settings').click (e)->
    e.preventDefault()
    data =
      email:    $('#business_accounts_attributes_new_email').val(),
      password: $('#business_accounts_attributes_new_password').val()
    $.post '/detect', data, (data)->
      console.log data
      if data and data['address']
        $('#business_accounts_attributes_new_connection_type').val( data['method'].toUpperCase() )
        $('#business_accounts_attributes_new_username').val( data['user_name'] )
        $('#business_accounts_attributes_new_address').val( data['address'] )
        $('#business_accounts_attributes_new_port').val( data['port'] )

