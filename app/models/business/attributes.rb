module Business::Attributes
  extend ActiveSupport::Concern
  included do
    attr_accessible :business_name, :corporate_name, :duns_number, :sic_code
    attr_accessible :contact_gender, :contact_prefix, :contact_first_name, :contact_middle_name, :contact_last_name, :contact_birthday
    attr_accessible :local_phone, :alternate_phone, :toll_free_phone, :mobile_phone, :mobile_appears, :fax_number
    attr_accessible :address, :address2, :city, :state, :zip
    attr_accessible :open_24_hours, :open_by_appointment
    attr_accessible :monday_enabled, :tuesday_enabled, :wednesday_enabled, :thursday_enabled, :friday_enabled, :saturday_enabled, :sunday_enabled
    attr_accessible :monday_open, :monday_close, :tuesday_open, :tuesday_close, :wednesday_open, :wednesday_close, :thursday_open, :thursday_close, :friday_open, :friday_close, :saturday_open, :saturday_close, :sunday_open, :sunday_close
    attr_accessible :accepts_cash, :accepts_checks, :accepts_mastercard, :accepts_visa, :accepts_discover, :accepts_diners, :accepts_amex, :accepts_paypal, :accepts_bitcoin
    attr_accessible :business_description, :services_offered, :specialies, :professional_associations, :languages, :geographic_areas, :year_founded
    attr_accessible :company_website, :incentive_offers, :links_to_photos, :links_to_videos
    attr_accessible :category1, :category2, :category3, :category4, :category5
    attr_accessible :categorized
    attr_accessible :other_social_links, :positive_review_links
    attr_accessible :keyword1, :keyword2, :keyword3, :keyword4, :keyword5
    attr_accessible :competitors, :most_like, :industry_leaders
    attr_accessible :fan_page_url, :keywords, :status_message, :trade_license, :trade_license_number 
    attr_accessible :trade_license_locale, :trade_license_authority, :trade_license_expiration 
    attr_accessible :trade_license_description, :brands, :tag_line, :job_titles, :is_client_downloaded
    attr_accessible :temporary_draft_storage
  end
end
