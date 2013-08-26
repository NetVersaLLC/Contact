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

    Job.create(:name => 'Utils/ImageSync', :business_id => correct.id)
    Job.create(:name => 'Bing/SignUp', :business_id => correct.id)
    Job.create(:name => 'Bing/CreateRule', :business_id => correct.id)
    Job.create(:name => 'Bing/CreateListing', :business_id => correct.id)
    Job.create(:name => 'Bing/AdditionalDetails', :business_id => correct.id)
    Job.create(:name => 'Bing/VerifyMail', :business_id => correct.id)
    Job.create(:name => 'AngiesList/SignUp', :business_id => correct.id)
    Job.create(:name => 'AngiesList/CreateListing', :business_id => correct.id)
    Job.create(:name => 'Citisquare/ClaimListing', :business_id => correct.id)
    Job.create(:name => 'Insiderpage/SignUp', :business_id => correct.id)
    Job.create(:name => 'Insiderpage/Verify', :business_id => correct.id)
    Job.create(:name => 'Insiderpage/HandleListing', :business_id => correct.id)
    
    Job.create(:name => 'Utils/ImageSync', :business_id => missing.id)
    Job.create(:name => 'Bing/SignUp', :business_id => missing.id)
    Job.create(:name => 'Bing/CreateRule', :business_id => missing.id)
    Job.create(:name => 'Bing/CreateListing', :business_id => missing.id)
  end

	let(:correct) { FactoryGirl.create(:business) }
	let(:missing) { FactoryGirl.create(:business) }
	let(:empty) { FactoryGirl.create(:business) }

	it 'should return an empty list for a complete listing' do
		PayloadNode.find_missed_payloads(correct).length.should == 0
	end

  it 'should return a list of missed payloads for an incomplete listing' do
		PayloadNode.find_missed_payloads(missed).length.should == 4
  end

end
