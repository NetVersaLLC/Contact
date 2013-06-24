require 'spec_helper'

describe Business do
	describe "Associations" do
		it { should belong_to(:label) }
		it { should belong_to(:subscription) }
		it { should belong_to(:user) }

		it { should have_one(:transaction_event) }

		it { should have_many(:codes) }
		it { should have_many(:completed_jobs).order('position DESC') }
		it { should have_many(:failed_jobs).order('position DESC') }
		it { should have_many(:jobs).order('position DESC') }
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
		let!(:business) { create(:business) }

		it { should validate_presence_of(:brands) }
		it { should validate_presence_of(:job_titles) }
		it { should validate_presence_of(:keywords) }
		it { should validate_presence_of(:status_message) }
		it { should validate_presence_of(:tag_line) }
		it { should validate_presence_of(:services_offered) }

		it { should validate_presence_of(:category1) }
		it { should validate_presence_of(:category2) }
		it { should validate_presence_of(:category3) }

		it { should validate_presence_of(:business_description) }
		it { should ensure_length_of(:business_description).is_within(50..200) }

		it { should validate_presence_of(:business_name) }
		it { should validate_presence_of(:corporate_name) }
		it { should validate_presence_of(:contact_gender) }
		it { should validate_presence_of(:contact_first_name) }
		it { should validate_presence_of(:contact_last_name) }
		it { should validate_presence_of(:contact_birthday) }

		it { should validate_presence_of(:zip) }
		it { should validate_presence_of(:local_phone) }
		it { should validate_presence_of(:toll_free_phone) }
		it { should validate_presence_of(:mobile_phone) }
		it { should validate_presence_of(:fax_number) }

		it { should validate_presence_of(:geographic_areas) }
		it { should validate_presence_of(:year_founded) }
	end

	describe "Unvalidated Attributes" do

		its(:crunchbases_attributes) 		{ should be_present }
		its(:listwns_attributes) 				{ should be_present }
		its(:supermedia_attributes) 		{ should be_present }
		its(:localpages_attributes) 		{ should be_present }
		its(:localcensus_attributes) 		{ should be_present }
		its(:yippies_attributes) 				{ should be_present }
		its(:usyellowpages_attributes) 	{ should be_present }
		its(:manta_attributes) 					{ should be_present }

		its(:duns_number) 							{ should be_present }  
		its(:sic_code) 									{ should be_present }  
		its(:contact_prefix) 						{ should be_present }  
		its(:contact_middle_name) 			{ should be_present }  

		its(:mobile_appears) 						{ should be_present }  
		its(:address) 									{ should be_present }  
		its(:address2) 									{ should be_present }  
		its(:city) 											{ should be_present }  
		its(:state) 										{ should be_present }  
		its(:open_24_hours) 						{ should be_present }  
		its(:open_by_appointment) 			{ should be_present }

		its(:monday_enabled) 						{ should be_present }  
		its(:tuesday_enabled) 					{ should be_present }  
		its(:wednesday_enabled) 				{ should be_present }  
		its(:thursday_enabled) 					{ should be_present }  
		its(:friday_enabled) 						{ should be_present }  
		its(:saturday_enabled) 					{ should be_present }  
		its(:sunday_enabled) 						{ should be_present }  

		its(:monday_open) 							{ should be_present }  
		its(:monday_close) 							{ should be_present }  
		its(:tuesday_open) 							{ should be_present }  
		its(:tuesday_close) 						{ should be_present }  
		its(:wednesday_open) 						{ should be_present }  
		its(:wednesday_close) 					{ should be_present }  
		its(:thursday_open) 						{ should be_present }  
		its(:thursday_close) 						{ should be_present }  
		its(:friday_open) 							{ should be_present }  
		its(:friday_close) 							{ should be_present }  
		its(:saturday_open) 						{ should be_present }  
		its(:saturday_close)						{ should be_present }  
		its(:sunday_open) 							{ should be_present }  
		its(:sunday_close) 							{ should be_present }  

		its(:accepts_cash) 							{ should be_present }  
		its(:accepts_checks) 						{ should be_present }  
		its(:accepts_mastercard) 				{ should be_present }  
		its(:accepts_visa) 							{ should be_present }  
		its(:accepts_discover) 					{ should be_present }  
		its(:accepts_diners) 						{ should be_present }  
		its(:accepts_amex) 							{ should be_present }  
		its(:accepts_paypal) 						{ should be_present }  
		its(:accepts_bitcoin) 					{ should be_present }  
 
 		its(:status_message) 						{ should be_present }  
		its(:languages) 								{ should be_present }    
		its(:incentive_offers) 					{ should be_present }   
		its(:category4) 								{ should be_present }  
		its(:category5) 								{ should be_present }  

		its(:company_website) 					{ should be_present }  
		its(:other_social_links) 				{ should be_present }  
		its(:positive_review_links) 		{ should be_present }
		its(:links_to_photos) 					{ should be_present }  
		its(:links_to_videos) 					{ should be_present } 
		its(:fan_page_url) 							{ should be_present }  

		its(:specialies) 								{ should be_present }  
		its(:professional_associations) { should be_present }  
		its(:competitors) 							{ should be_present }  
		its(:most_like) 								{ should be_present }  
		its(:industry_leaders)					{ should be_present }  

		its(:keyword1) 									{ should be_present }  
		its(:keyword2) 									{ should be_present }  
		its(:keyword3) 									{ should be_present }  
		its(:keyword4) 									{ should be_present }  
		its(:keyword5) 									{ should be_present }  

		its(:trade_license) 						{ should be_present }  
		its(:trade_license_number) 			{ should be_present }  
		its(:trade_license_locale) 			{ should be_present }  
		its(:trade_license_authority) 	{ should be_present }  
		its(:trade_license_expiration)	{ should be_present }  
		its(:trade_license_description) { should be_present }  
  
		its(:is_client_downloaded) 			{ should be_present }  
	end

	describe "Respond to" do

		it { should respond_to(:birthday) }
		it { should respond_to(:checkin) }
		it { should respond_to(:complete_failed_job_hash) }		
		it { should respond_to(:create_jobs) }
		it { should respond_to(:create_site_accounts) }
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
		it { should respond_to(:time_cannot_be_same) }
	end

end