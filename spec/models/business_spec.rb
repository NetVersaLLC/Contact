require 'spec_helper'

describe Business do
	describe "Associations" do
	  
		it { should belong_to(:label) }
		it { should belong_to(:subscription) }
		it { should belong_to(:user) }
    if { should belong_to(:sales_person) }

		it { should have_one(:transaction_event) }

		it { should have_many(:codes) }
		it { should have_many(:completed_jobs).order('position') }
		it { should have_many(:failed_jobs).order('position') }
		it { should have_many(:jobs).order('position') }
		it { should have_many(:images) }
		it { should have_many(:notifications) }

		it { should have_many(:crunchbases) }
		it { should have_many(:listwns) }
		it { should have_many(:supermedia) }
		it { should have_many(:localpages) }
		it { should have_many(:localcensus) }
		it { should have_many(:yippies) }
		it { should have_many(:usyellowpages) }
		it { should have_many(:manta) }
	end

	describe "Validation" do
	  let(:business) { FactoryGirl.build(:business) }

		it { should validate_presence_of(:brands) }
		it { should validate_presence_of(:job_titles) }
		it { should validate_presence_of(:keywords) }
		it { should validate_presence_of(:status_message) }
		it { should validate_presence_of(:tag_line) }
		it { should validate_presence_of(:services_offered) }

		it { should validate_presence_of(:category_description) }
		#it { should validate_presence_of(:category1) }
		#it { should validate_presence_of(:category2) }
		#it { should validate_presence_of(:category3) }

		it { should validate_presence_of(:business_description) }
		#it { should ensure_length_of(:business_description).is_within(50..200) }

		it { should validate_presence_of(:business_name) }
		it { should validate_presence_of(:corporate_name) }
		it { should validate_presence_of(:contact_gender) }
		it { should validate_presence_of(:contact_first_name) }
		it { should validate_presence_of(:contact_last_name) }
		#it { should validate_presence_of(:contact_birthday) }

		it { should validate_presence_of(:zip) }
		it { should validate_presence_of(:local_phone) }
		#it { should validate_presence_of(:toll_free_phone) }
		it { should validate_presence_of(:mobile_phone) }
		#it { should validate_presence_of(:fax_number) }

		it { should validate_presence_of(:geographic_areas) }
		#it { should validate_presence_of(:year_founded) }
	end

	describe "Attributes Without Validation" do

	it { should allow_mass_assignment_of :duns_number }  
	it { should allow_mass_assignment_of :sic_code }  
	it { should allow_mass_assignment_of :contact_prefix }   
	it { should allow_mass_assignment_of :contact_middle_name }    
	it { should allow_mass_assignment_of :alternate_phone }  
	it { should allow_mass_assignment_of :mobile_appears }  
	it { should allow_mass_assignment_of :address }  
	it { should allow_mass_assignment_of :address2 }  
	it { should allow_mass_assignment_of :city }  
	it { should allow_mass_assignment_of :state }  
	it { should allow_mass_assignment_of :open_24_hours }  
	it { should allow_mass_assignment_of :open_by_appointment }  
	it { should allow_mass_assignment_of :monday_enabled }  
	it { should allow_mass_assignment_of :tuesday_enabled }  
	it { should allow_mass_assignment_of :wednesday_enabled }  
	it { should allow_mass_assignment_of :thursday_enabled }  
	it { should allow_mass_assignment_of :friday_enabled }  
	it { should allow_mass_assignment_of :saturday_enabled }  
	it { should allow_mass_assignment_of :sunday_enabled }  
	it { should allow_mass_assignment_of :monday_open }  
	it { should allow_mass_assignment_of :monday_close }  
	it { should allow_mass_assignment_of :tuesday_open }  
	it { should allow_mass_assignment_of :tuesday_close }  
	it { should allow_mass_assignment_of :wednesday_open }  
	it { should allow_mass_assignment_of :wednesday_close }  
	it { should allow_mass_assignment_of :thursday_open }  
	it { should allow_mass_assignment_of :thursday_close }  
	it { should allow_mass_assignment_of :friday_open }  
	it { should allow_mass_assignment_of :friday_close }  
	it { should allow_mass_assignment_of :saturday_open }  
	it { should allow_mass_assignment_of :saturday_close }  
	it { should allow_mass_assignment_of :sunday_open }  
	it { should allow_mass_assignment_of :sunday_close }  
	it { should allow_mass_assignment_of :accepts_cash }  
	it { should allow_mass_assignment_of :accepts_checks }  
	it { should allow_mass_assignment_of :accepts_mastercard }  
	it { should allow_mass_assignment_of :accepts_visa }  
	it { should allow_mass_assignment_of :accepts_discover }  
	it { should allow_mass_assignment_of :accepts_diners }  
	it { should allow_mass_assignment_of :accepts_amex }  
	it { should allow_mass_assignment_of :accepts_paypal }  
	it { should allow_mass_assignment_of :accepts_bitcoin }  
	it { should allow_mass_assignment_of :business_description }  
	it { should allow_mass_assignment_of :services_offered }  
	it { should allow_mass_assignment_of :specialies }  
	it { should allow_mass_assignment_of :professional_associations }  
	it { should allow_mass_assignment_of :languages }  
	it { should allow_mass_assignment_of :year_founded }  
	it { should allow_mass_assignment_of :company_website }  
	it { should allow_mass_assignment_of :incentive_offers }  
	it { should allow_mass_assignment_of :links_to_photos }  
	it { should allow_mass_assignment_of :links_to_videos }  
	it { should allow_mass_assignment_of :category4 }  
	it { should allow_mass_assignment_of :category5 }  
	it { should allow_mass_assignment_of :other_social_links }  
	it { should allow_mass_assignment_of :positive_review_links }  
	it { should allow_mass_assignment_of :keyword1 }  
	it { should allow_mass_assignment_of :keyword2 }  
	it { should allow_mass_assignment_of :keyword3 }  
	it { should allow_mass_assignment_of :keyword4 }  
	it { should allow_mass_assignment_of :keyword5 }  
	it { should allow_mass_assignment_of :competitors }  
	it { should allow_mass_assignment_of :most_like }  
	it { should allow_mass_assignment_of :industry_leaders }  
	it { should allow_mass_assignment_of :fan_page_url }  
	it { should allow_mass_assignment_of :status_message }  
	it { should allow_mass_assignment_of :trade_license }  
	it { should allow_mass_assignment_of :trade_license_number }  
	it { should allow_mass_assignment_of :trade_license_locale }  
	it { should allow_mass_assignment_of :trade_license_authority }  
	it { should allow_mass_assignment_of :trade_license_expiration }  
	it { should allow_mass_assignment_of :trade_license_description }  
	it { should allow_mass_assignment_of :is_client_downloaded }  
 
end

	describe "Respond to" do
    let(:business) { FactoryGirl.build(:business) }
    
		it { should respond_to(:birthday) }
		it { should respond_to(:create_jobs) }
		#it { should respond_to(:create_site_accounts) }
		it { should respond_to(:get_keywords) }
		it { should respond_to(:get_brands) }
		it { should respond_to(:label_id) }
		it { should respond_to(:logo) }	
		it { should respond_to(:name) }			
		it { should respond_to(:nonexistent_accounts) }
		it { should respond_to(:nonexistent_accounts_array) }						
		it { should respond_to(:payload_status_data) }
		it { should respond_to(:payment_methods) }			
		it { should respond_to(:report_xlsx) }		
		it { should respond_to(:set_times) }
		it { should respond_to(:sites) }		
		it { should respond_to(:state_name) }	
		it { should respond_to(:strip_blanks) }
		it { should respond_to(:time_cannot_same) }
	end
end
