require 'spec_helper'

describe PayloadNode do
  before(:each) do
    @root = PayloadNode.new(:name => "Utils/ImageSync")
    @root.id = 0
    @root.save
    @bing_su   = @root.children.create(:name => "Bing/SignUp")
    @bing_cr   = @bing_su.children.create(:name => "Bing/CreateRule")
    @bing_cl   = @bing_cr.children.create(:name => "Bing/CreateListing")
    @bing_ad   = @bing_cl.children.create(:name => "Bing/AdditionalDetails")
    @bing_vm   = @bing_ad.children.create(:name => "Bing/VerifyMail")
    @bing_mn   = @bing_vm.children.create(:name => "Bing/MailNotify")
    @bing_cll  = @bing_cl.children.create(:name => "Bing/ClaimListing")
    @bing_ul   = @bing_cll.children.create(:name => "Bing/UpdateListing")
    @al_su     = @bing_su.children.create(:name => "AngiesList/SignUp")
    @al_cl     = @al_su.children.create(:name => "AngiesList/CreateListing")
    @cs_su     = @bing_su.children.create(:name => "Citisquare/SignUp")
    @cs_cl     = @cs_su.children.create(:name => "Citisquare/ClaimListing")
    @in_su     = @bing_su.children.create(:name => "Insiderpage/SignUp")
    @in_ve     = @in_su.children.create(:name => "Insiderpage/Verify")
    @in_hl     = @in_ve.children.create(:name => "Insiderpage/HandleListing")
  end

	it { should have_many :transaction_events}
	it { should belong_to :label }
	it { should belong_to :business }
	it { should belong_to :transaction_event }
	
	let(:payment) { FactoryGirl.build(:payment) }

	it 'is valid with valid attributes' do
		payment.should be_valid
	end

	describe '#label_id' do
	  it 'is required' do
	  	payment.label_id = nil
	  	payment.should_not be_valid
	  end
	end

end
