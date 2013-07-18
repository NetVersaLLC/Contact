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
    validates :category2,
      :presence => true
    validates :category3,
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
    validates :local_phone,
      :presence => true,
      :format => { :with => phone_regex, :message => 'Invalid format'}
    validates :alternate_phone,
      :allow_blank => true,
      :format => { :with => phone_regex,:message => 'Invalid format' }
    validates :toll_free_phone,
	  :allow_blank => true,
      :format => { :with => /^(?:888|877|866|855|844|833|822|800)-\d\d\d-\d\d\d\d$/, :message => 'Invalid format'}
    validates :mobile_phone,
      :presence => true,      
      :format => { :with => phone_regex, :message => 'Invalid format' }
    validates :fax_number,
      :allow_blank => true,
      :format => { :with => phone_regex, :message => 'Invalid format' }
    #validates :address,
    #  :presence => true
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
