require 'spec_helper'

describe PayloadNode do

  before(:each) do
    @root = PayloadNode.new(:name => "Utils/ImageSync")
    @root.parent_id = nil
    @root.id = 0
    @root.save
    @bing_su   = @root.add_child_payload("Bing/SignUp")
    @bing_cr   = @bing_su.add_child_payload("Bing/CreateRule")
    @bing_cl   = @bing_cr.add_child_payload("Bing/CreateListing")
    @bing_ad   = @bing_cl.add_child_payload("Bing/AdditionalDetails")
    @bing_vm   = @bing_ad.add_child_payload("Bing/VerifyMail")
    @bing_mn   = @bing_vm.add_child_payload("Bing/MailNotify")
    @bing_cll  = @bing_cl.add_child_payload("Bing/ClaimListing")
    @bing_ul   = @bing_cll.add_child_payload("Bing/UpdateListing")
    @al_su     = @bing_su.add_child_payload("AngiesList/SignUp")
    @al_cl     = @al_su.add_child_payload("AngiesList/CreateListing")
    @cs_su     = @bing_su.add_child_payload("Citisquare/SignUp")
    @cs_cl     = @cs_su.add_child_payload("Citisquare/ClaimListing")
    @in_su     = @bing_su.add_child_payload("Insiderpage/SignUp")
    @in_ve     = @in_su.add_child_payload("Insiderpage/Verify")
    @in_hl     = @in_ve.add_child_payload("Insiderpage/HandleListing")
  end
  let(:user) { FactoryGirl.create(:user) }

  it 'should return an empty list for a complete listing' do
    @correct = FactoryGirl.create(:business, :user => user)
    CompletedJob.create(:name => 'Utils/ImageSync', :business_id => @correct.id)
    CompletedJob.create(:name => 'Bing/SignUp', :business_id => @correct.id)
    CompletedJob.create(:name => 'Bing/CreateRule', :business_id => @correct.id)
    CompletedJob.create(:name => 'Bing/CreateListing', :business_id => @correct.id)
    CompletedJob.create(:name => 'Bing/AdditionalDetails', :business_id => @correct.id)
    Job.create(:name => 'Bing/VerifyMail', :business_id => @correct.id)
    Job.create(:name => 'AngiesList/SignUp', :business_id => @correct.id)
    Job.create(:name => 'AngiesList/CreateListing', :business_id => @correct.id)
    Job.create(:name => 'Citisquare/ClaimListing', :business_id => @correct.id)
    Job.create(:name => 'Insiderpage/SignUp', :business_id => @correct.id)
    Job.create(:name => 'Insiderpage/Verify', :business_id => @correct.id)
    Job.create(:name => 'Insiderpage/HandleListing', :business_id => @correct.id)

    STDERR.puts "list of completed payloads"
    PayloadNode.find_missed_payloads(@correct).length.should == 0
  end

  it 'should return a list of missed payloads for an incomplete listing' do
    @missing = FactoryGirl.create(:business, :user => user)
    CompletedJob.create(:name => 'Utils/ImageSync', :business_id => @missing.id)
    CompletedJob.create(:name => 'Bing/SignUp', :business_id => @missing.id)
    Job.create(:name => 'Bing/CreateRule', :business_id => @missing.id)
    Job.create(:name => 'Bing/CreateListing', :business_id => @missing.id)

    STDERR.puts "list of missing payloads"
    PayloadNode.find_missed_payloads(@missing).length.should == 4
  end

end
