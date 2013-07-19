ClientSideValidations.validators.local["keyword_count"] = (element, options) -> options.message if element.val().split(",").length > 10

