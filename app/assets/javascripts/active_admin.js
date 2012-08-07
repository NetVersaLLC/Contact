//= require active_admin/base
//= require jquery
//= require jquery_ujs
//= require aa-jquery-ui
//= require active_admin_clients
//= require fg

$(document).ready(function() {
  $('.categoryPicker').each(function(i,e) { 
    $('#'+$(e).attr('id')).menu({
      content: $('#yelpCategories').html(),
      backLink: false
    });
  });
});
