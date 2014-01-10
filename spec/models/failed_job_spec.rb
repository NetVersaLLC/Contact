require 'spec_helper'

describe FailedJob do
	it { should belong_to :business }
	it { should belong_to :screenshot}

  it 'status messages are applied to the failed object' do 
    job = Job.new(payload: "payload", status_message: "started", status: "started", business_id: 0, name: "job name")
    failed = job.failure("stupid thing broke", "this is a backtrace", nil ) 

    failed.status_message.should eq( "stupid thing broke")
    failed.backtrace.should eq("this is a backtrace")
  end 

  it 'job to failed_job creates a grouping hash' do 
    job = Job.new(payload: "payload", status_message: "started", status: "started", business_id: 0, name: "job name")
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


  it 'should report distinct payloads with an error grouped by site' do 
    bing = Site.create(name: 'bing')
    yahoo = Site.create(name: 'yahoo')
    payload_bingA  = Payload.create(name: 'bing/signup', site: bing )
    payload_bingB  = Payload.create(name: 'bing/dontcare', site: bing )
    payload_yahooA = Payload.create(name: 'yahoo/signup', site: yahoo) 
    payload_yahooB = Payload.create(name: 'yahoo/dontcare', site: yahoo) 

    # two different payloads failed for bing
    job = Job.new(payload: "payload", status_message: "started", status: "started", business_id: 0, name: "job name", payload_id: payload_bingA.id)
    job.add_failed_job({'status_message' => "stupid thing broke", 'backtrace' => "backtrace: ./lib/contact"} )
    job.add_failed_job({'status_message' => "stupid thing broke", 'backtrace' => "backtrace: ./lib/contact"} )
    
    job = Job.new(payload: "payload", status_message: "started", status: "started", business_id: 0, name: "job name", payload_id: payload_bingB.id)
    job.add_failed_job({'status_message' => "stupid thing broke", 'backtrace' => "backtrace: ./lib/contact"} )
   
    # onen payload failed
    job = Job.new(payload: "payload", status_message: "started", status: "started", business_id: 0, name: "job name", payload_id: payload_yahooA.id)
    job.add_failed_job({'status_message' => "stupid thing broke", 'backtrace' => "backtrace: ./lib/contact"} )

    rows = FailedJob.errors_report
    rows.length.should eq(2) 
    rows[0]['name'].should eq('bing') 
    rows[0]['payloads_with_errors'].should eq(2) 
    rows[1]['name'].should eq('yahoo') 
    rows[1]['payloads_with_errors'].should eq(1)
  end 

end

