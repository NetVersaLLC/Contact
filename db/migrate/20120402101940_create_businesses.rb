class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :business_name
      t.string :corporate_name
      t.string :duns_number
      t.string :sic_code
      t.string :contact_gender
      t.string :contact_prefix
      t.string :contact_first_name
      t.string :contact_middle_name
      t.string :contact_last_name
      t.string :company_email
      t.string :local_phone
      t.string :alternate_phone
      t.string :toll_free_phone
      t.string :mobile_phone
      t.boolean :mobile_appears
      t.string :fax_number
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.text :languages
    # "Hours"
      t.boolean :open_24_hours
      t.boolean :open_by_appointment
      t.boolean :monday_enabled
      t.boolean :tuesday_enabled
      t.boolean :wednesday_enabled
      t.boolean :thursday_enabled
      t.boolean :friday_enabled
      t.boolean :saturday_enabled
      t.boolean :sunday_enabled
      t.string :monday_open
      t.string :monday_close
      t.string :tuesday_open
      t.string :tuesday_close
      t.string :wednesday_open
      t.string :wednesday_close
      t.string :thursday_open
      t.string :thursday_close
      t.string :friday_open
      t.string :friday_close
      t.string :saturday_open
      t.string :saturday_close
      t.string :sunday_open
      t.string :sunday_close
      # t.string :payment_types
      t.boolean :accepts_cash
      t.boolean :accepts_checks
      t.boolean :accepts_mastercard
      t.boolean :accepts_visa
      t.boolean :accepts_discover
      t.boolean :accepts_diners
      t.boolean :accepts_amex
      t.boolean :accepts_paypal
      t.boolean :accepts_bitcoin
    # "Company Description"
      t.text :business_description
      t.string :services_offered
      t.string :specialies
      t.string :professional_associations
      t.string :geographic_areas
      t.string :year_founded
    # "Web Presence"
      t.string :company_website
      t.string :incentive_offers
      t.string :links_to_photos
      t.string :links_to_videos
    # 'Social Networking & Review Sites'
      t.string :fan_page_url
      t.text   :other_social_links
      t.text   :positive_review_links
      t.string :keyword1
      t.string :keyword2
      t.string :keyword3
      t.string :keyword4
      t.string :keyword5
    # "Competitors"
      t.text   :competitors
      t.string :most_like
      t.string :industry_leaders

      t.string  :mail_host
      t.integer :mail_port
      t.string  :mail_username
      t.text    :mail_password

      t.has_attached_file :logo
      t.timestamps
    end
  end
end
