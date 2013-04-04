ClientSideValidations.formBuilders["FormtasticBootstrap::FormBuilder"] = {
  add: function (element, settings, message) {
    if (element.data('valid') !== false) {
      element.addClass('error').data('valid', false);
      var $parent = element.closest('.control-group');
      $parent.addClass('error');
      $('<span/>').addClass('error-inline help-inline').text(message).appendTo($parent);
    } else {
      //element.parent().find('span.help-inline').text(message);
    }
  },
  remove: function (element, settings) {
    var $parent = element.closest('.control-group');
    $parent.removeClass('error');
    $parent.find('span.error-inline').remove();
    element.data("valid", true);
    element.removeClass('error');
  }
};

