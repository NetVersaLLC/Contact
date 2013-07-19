class KeywordCountValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
      object.errors[attribute] << "only 10 allowed" if value.try(:split, ",").try(:count) > 10
  end
end
