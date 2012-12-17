module Business::Validations
  extend ActiveSupport::Concern
  included do
    def self.phone_regex
      /^\d\d\d-\d\d\d-\d\d\d\d$/
    end

    validates :category1,
      :presence => true
    validates :category2,
      :presence => true
    validates :category3,
      :presence => true
    validates :business_name,
      :presence => true
    validates :contact_gender,
      :presence => true
    validates :contact_first_name,
      :presence => true
    validates :contact_last_name,
      :presence => true
    validates :local_phone,
      :presence => true,
      :format => { :with => phone_regex }
    validates :alternate_phone,
      :allow_blank => true,
      :format => { :with => phone_regex }
    validates :toll_free_phone,
      :allow_blank => true,
      :format => { :with => /^(?:888|877|866|855|844|833|822|800)-\d\d\d-\d\d\d\d$/ }
    validates :mobile_phone,
      :allow_blank => true,
      :format => { :with => phone_regex }
    validates :fax_number,
      :allow_blank => true,
      :format => { :with => phone_regex }
    validates :address,
      :presence => true
    validates :business_description,
      :presence => true
    validates :geographic_areas,
      :presence => true
    validates :year_founded,
      :presence => true
    validates :fan_page_url,
      :allow_blank => true,
      :format => { :with => /^https?\:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(\/\S*)?$/ }
    validates :contact_birthday,
      :presence => true,
      :format => { :with => /^\d\d\/\d\d\/\d\d\d\d$/ }
  end
end
