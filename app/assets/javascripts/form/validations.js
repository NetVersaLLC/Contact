jQuery(function($){

    $('#location-wizard').ace_wizard().on('finished', function(e){ 
      $(".edit_business, .new_business").submit();
        }).on('change', function(e, info){ 
          return $(".edit_business, .new_business").valid();
        });

        $('.edit_business, .new_business').validate({
          errorElement: 'div',
          errorClass: 'help-block inline',
          focusInvalid: false,
          rules: {
            "business[business_name]": { 
              required: true
              },
            "business[corporate_name]": { 
              required: true, 
              maxlength: 50
              },
            "business[local_phone]": { 
              required: true, 
              phoneUS: true
              },
            "business[zip]": { 
              required: true,
              digits: true,
              rangelength: [5, 5]
              },
            "business[alternate_phone]": { 
              phoneUS: true
              },
            "business[toll_free_phone]": { 
              phoneUS: true
              },
            "business[description]": { 
              required: true, 
              rangelength: [50, 200]
              },
            "business[keywords]": { 
              required: true
              },
            "business[status_message]": { 
              required: true
              },
            "business[services_offered]": { 
              required: true
              },
            "business[brands]": { 
              required: true
              },
            "business[tag_line]": { 
              required: true
              },
            "business[keywords]": { 
              required: true
              },
            "business[job_titles]": { 
              required: true
              }, 
            "business[category1]": { 
              required: true
              },
            "business[category2]": { 
              required: true
              },
            "business[category3]": { 
              required: true
              }
          },
      
          messages: {
            email: {
              required: "Please provide a valid email.",
              email: "Please provide a valid email."
            },
            password: {
              required: "Please specify a password.",
              minlength: "Please specify a secure password."
            },
            subscription: "Please choose at least one option",
            gender: "Please choose gender",
            agree: "Please accept our policy"
          },
      
          invalidHandler: function (event, validator) { //display error alert on form submit   
            $('.alert-danger', $('.login-form')).show();
          },
      
          highlight: function (e) {
            $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
          },
      
          success: function (e) {
            $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
            $(e).remove();
          },
      
          errorPlacement: function (error, element) {
            if(element.is(':checkbox') || element.is(':radio')) {
              var controls = element.closest('div[class*="col-"]');
              if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
              else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
            }
            else if(element.is('.select2')) {
              error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
            }
            else if(element.is('.chosen-select')) {
              error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
            }
            else error.insertAfter(element.parent());
          },
      
          submitHandler: function (form) {
          },
          invalidHandler: function (form) {
          }
        });
}); 