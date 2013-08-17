class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    unless value =~ /^(?:\d\d\d-\d\d\d-\d\d\d\d)|(?:___-___-____)$/
      record.errors.add(attr_name, :phone, options.merge(:value => value))
    end
  end
end

# This allows us to assign the validator in the model
module ActiveModel::Validations::HelperMethods
  def validates_phone(*attr_names)
    validates_with PhoneValidator, _merge_attributes(attr_names)
  end
end

module Business::Validations
  extend ActiveSupport::Concern
  included do
    def self.phone_regex
      /^\d\d\d-\d\d\d-\d\d\d\d$/
    end
    def self.zip_regex
      /^\d{3,12}$/
    end

    
    validates :keywords,
      :presence => true
    validates :status_message,
      :presence => true
    validates :services_offered,
      :presence => true
    validates :brands,
      :presence => true
    validates :tag_line,
      :presence => true
    validates :job_titles,
      :presence => true

    validates :category1,
      :presence => true
    validates :business_name,
      :presence => true
    validates :corporate_name, :length => { :maximum => 50 },
      :presence => true
    validates :zip,
      :presence => true,
      :format => { :with => zip_regex, :message => 'Invalid format'}
    validates :contact_gender,
      :presence => true
    validates :contact_first_name,
      :presence => true
    validates :contact_last_name,
      :presence => true

    validates_phone :local_phone
    validates_phone :alternate_phone
    validates_phone :toll_free_phone
    validates_phone :mobile_phone
    validates_phone :fax_number
    
      validates :business_description, :presence => true, :length => {:minimum => 50, :maximum => 200}
    validates :geographic_areas,
      :presence => true
    validates :year_founded,
      :presence => true,
      :numericality => { 
        :only_integer => true, 
        :greater_than => 1000, 
        :less_than => Date.current.year + 1 
        }
    # enforce m/d/yyyy, and mm/dd/yyyy.  mm 1-12, dd 1-31 
    validates :contact_birthday,
      :allow_blank => true,
      :format => { :with => /^(0{0,1}[1-9]|1[012])\/(\d|[012]\d|3[01])\/((19|20)\d\d)$/ } #/^\d\d\/\d\d\/\d\d\d\d$/ }

    def time_cannot_same
      errors.add(:monday_open,'') if self.monday_open == self.monday_close && self.open_24_hours == false
      errors.add(:tuesday_open,'') if self.tuesday_open == self.tuesday_close && self.open_24_hours == false
      errors.add(:wednesday_open,'') if self.wednesday_open == self.wednesday_close && self.open_24_hours == false
      errors.add(:thursday_open,'') if self.thursday_open == self.thursday_close && self.open_24_hours == false
      errors.add(:friday_open,'') if self.friday_open == self.friday_close && self.open_24_hours == false
      errors.add(:saturday_open,'') if self.saturday_open == self.saturday_close && self.open_24_hours == false
      errors.add(:sunday_open,'') if self.sunday_open == self.sunday_close && self.open_24_hours == false
    end
  end
end
