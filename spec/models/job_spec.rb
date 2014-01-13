require 'spec_helper'

describe Job do
  it { should belong_to :business }
  it { should belong_to :screenshot}

  it 'should requeue a stalled Bing/SignUp job' do 
    site    = Site.create(:name => 'Bing')
    b = Business.new
    b.id = 100 

    payload = Payload.new
    payload.site = site 
    payload.name = 'SignUp' 
    payload.client_script = 'client_script' 
    payload.data_generator = 'data_generator' 
    payload.save

    j = Job.inject( b.id, payload.client_script, payload.data_generator, payload.ready,  10.hours.ago)
    j.update_attribute( :name, 'Bing/SignUp')
    j.start
    j.update_attribute(:waited_at, 20.minutes.ago)

    Job.pending(b)

    FailedJob.count.should eq(1) 
    Job.count.should       eq(1)

  end 


  end 
