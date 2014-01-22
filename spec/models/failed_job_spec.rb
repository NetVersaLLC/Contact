require 'spec_helper'

describe FailedJob do
	it { should belong_to :business }
	it { should belong_to :screenshot}

  it 'status messages are applied to the failed object' do 
    business = FactoryGirl.create(:business)

    job = Job.new(payload: "payload", status_message: "started", status: "started", name: "job name")
    job.business = business 
    failed = job.failure("stupid thing broke", "this is a backtrace", nil ) 

    failed.status_message.should eq( "stupid thing broke")
    failed.backtrace.should eq("this is a backtrace")
  end 

  it 'job to failed_job creates a grouping hash' do 
    business = FactoryGirl.create(:business)

    job = Job.new(payload: "payload", status_message: "started", status: "started", name: "job name")
    job.business = business 
    failed = job.failure("stupid thing broke", "this is a backtrace", nil ) 

    failed.grouping_hash.should eq( Digest::MD5.hexdigest("stupid thing broke" + "this is a backtrace") )
  end 

  it 'adding a failed_job creates a grouping hash' do 
    job = Job.new(payload: "payload", status_message: "started", status: "started", business_id: 0, name: "job name")
    failed = job.add_failed_job({'status_message' => "stupid thing broke", 'backtrace' => "this is a backtrace"} )

    failed.grouping_hash.should eq( Digest::MD5.hexdigest("stupid thing broke" + "this is a backtrace") )
  end 

  it 'should group failed jobs with the same error message' do 
    job = Job.new(payload: "payload", status_message: "started", status: "started", business_id: 0, name: "job name")

    5.times.each do |i|
      job.add_failed_job({'status_message' => "stupid thing broke", 'backtrace' => "this is a backtrace"} )
    end 

    FailedJob.select("grouping_hash").group("grouping_hash").length.should eq(1)
  end 

  it 'should group failed jobs with the same error message but different object ids' do 
    job = Job.new(payload: "payload", status_message: "started", status: "started", business_id: 0, name: "job name")

    5.times.each do |i|
      job.add_failed_job({'status_message' => "stupid thing broke", 'backtrace' => "business' for #<ContactJob:0x427d41#{i}>: ./lib/contact"} )
    end 

    FailedJob.select("grouping_hash").group("grouping_hash").length.should eq(1)
  end 

  it 'should multiple groups of failed jobs with different error messages' do 
    job = Job.new(payload: "payload", status_message: "started", status: "started", business_id: 0, name: "job name")

    5.times.each do |i|
      job.add_failed_job({'status_message' => "stupid thing broke#{i}", 'backtrace' => "this #{i}is a backtrace"} )
    end 

    FailedJob.select("grouping_hash").group("grouping_hash").length.should eq(5)
  end 

  it 'should handle nil error messages gracefully' do 
    job = Job.new(payload: "payload", status_message: "started", status: "started", business_id: 0, name: "job name")

    job.add_failed_job({'status_message' => nil, 'backtrace' => "this is a backtrace"} )
    job.add_failed_job({'status_message' => 'im broken', 'backtrace' => nil} )
    job.add_failed_job({'status_message' => nil, 'backtrace' => nil} )

    FailedJob.select("grouping_hash").group("grouping_hash").length.should eq(3)
  end 


  it 'should report payloads grouped by site with a count for affected customers' do 
    business = create(:business)

    bing  = Site.create(name: 'bing')
    yahoo = Site.create(name: 'yahoo')
    payload_bingA  = Payload.create(name: 'bing/signup', site: bing )
    payload_bingB  = Payload.create(name: 'bing/dontcare', site: bing )
    payload_yahooA = Payload.create(name: 'yahoo/signup', site: yahoo) 
    payload_yahooB = Payload.create(name: 'yahoo/dontcare', site: yahoo) 

    # two different payloads failed for bing
    job = Job.new(payload: "payload", status_message: "started", status: "started", business_id: 0, name: "job name", payload_id: payload_bingA.id)
    job.business = business
    job.add_failed_job({'status_message' => "stupid thing broke", 'backtrace' => "backtrace: ./lib/contact"} )
    job.add_failed_job({'status_message' => "stupid thing broke", 'backtrace' => "backtrace: ./lib/contact"} )
    
    job = Job.new(payload: "payload", status_message: "started", status: "started", business_id: 0, name: "job name", payload_id: payload_bingB.id)
    job.business = business
    job.add_failed_job({'status_message' => "stupid thing broke", 'backtrace' => "backtrace: ./lib/contact"} )
   
    # onen payload failed
    job = Job.new(payload: "payload", status_message: "started", status: "started", business_id: 0, name: "job name", payload_id: payload_yahooA.id)
    job.business = business
    job.add_failed_job({'status_message' => "stupid thing broke", 'backtrace' => "backtrace: ./lib/contact"} )

    current_ability = Ability.new( business.user ) 
    rows = FailedJob.errors_report current_ability
    rows.length.should eq(2) 
    rows[0]['name'].should eq('bing') 
    rows[0]['customers_with_errors'].should eq(1) 
    rows[1]['name'].should eq('yahoo') 
    rows[1]['customers_with_errors'].should eq(1)
  end 

  it 'should resolve failed jobs' do 
    business = create(:business)
    site     = create(:site, name: 'Yahoo')

    payload = Payload.new
    payload.site = site 
    payload.name = 'SignUp' 
    payload.client_script = 'client_script' 
    payload.data_generator = 'data_generator' 
    payload.save

    job    = Job.inject( business, payload )
    failed = job.failure("stupid thing broke", "this is a backtrace", nil )

    FailedJob.resolve_by_grouping_hash(failed.grouping_hash)
    FailedJob.all.count.should eq(0) 

    Job.all.count.should eq(1) 

    job    = Job.inject( business, payload )
    failed = job.failure("stupid thing broke", "this is a backtrace", nil )

    FailedJob.resolve_by_grouping_hash(failed.grouping_hash, false )
    FailedJob.all.count.should eq(0) 

    Job.all.count.should eq(0) 
  end 

  it 'should create a site errors report' do 
    business = create(:business)
    site     = create(:site, name: 'Yahoo')

    payload = Payload.new
    payload.site = site 
    payload.name = 'SignUp' 
    payload.client_script = 'client_script' 
    payload.data_generator = 'data_generator' 
    payload.save

    job    = Job.inject( business, payload )
    failed = job.failure("stupid thing broke", "this is a backtrace", nil )

    current_ability = Ability.new( business.user ) 
    rows = FailedJob.site_errors_report( current_ability, site.name )

    rows.length.should eq(1) 

    row = rows.first
    row['grouping_hash'].should_not == nil
    row['id'].should_not == nil
  end 

end

