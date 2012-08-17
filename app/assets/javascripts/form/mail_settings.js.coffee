$(document).read ->
  $('#business_accounts_attributes_new_email').after('<button class="btn btn-info" onclick="window.detectEmailSettings();">Detect Email Settings</button>')
