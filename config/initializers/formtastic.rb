Formtastic::Helpers::FormHelper.builder = FormtasticBootstrap::FormBuilder
# Set the way inline errors will be displayed.
# Defaults to :sentence, valid options are :sentence, :list, :first and :none
# story 47195909.  Changed from sentence to first error 
Formtastic::FormBuilder.inline_errors = :first
