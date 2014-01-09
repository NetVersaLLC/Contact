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
end


