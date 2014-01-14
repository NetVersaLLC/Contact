require 'spec_helper'

describe Job do
	it { should belong_to :business }
	it { should belong_to :screenshot}

  it 'should set required values when it "injects" itself' do 
    site    = Site.create(:name => 'Yahoo')
    payload = Payload.new
    payload.site = site 
    payload.name = 'SignUp' 
    payload.client_script = 'client_script' 
    payload.data_generator = 'data_generator' 
    payload.save

    business_id = 100

    j = Job.inject( business_id, payload )

    j.name.should           eq( "#{site.name}/#{payload.name}") 
    j.business_id.should    eq(business_id) 
    j.payload_id.should     eq(payload.id) 
    j.payload.should        eq(payload.client_script) 
    j.data_generator.should eq(payload.data_generator) 
    j.ready.should          eq(payload.ready) 
    j.status_message.should eq('Created') 
    j.status.should         eq( Job::TO_CODE[:new] )
  end 

  it 'should set the parent job when it exists on injection' do 
    business_id = 100
    site    = Site.create(:name => 'Yahoo')

    parent_payload = Payload.new
    parent_payload.site = site 
    parent_payload.name = 'SignUp' 
    parent_payload.client_script = 'client_script' 
    parent_payload.data_generator = 'data_generator' 
    parent_payload.save

    payload = Payload.new
    payload.parent_id = parent_payload.id
    payload.site = site 
    payload.name = 'AChild' 
    payload.client_script = 'client_script' 
    payload.data_generator = 'data_generator' 
    payload.save

    cj = CompletedJob.new
    cj.business_id = business_id
    cj.name = "#{site.name}/#{parent_payload.name}" 
    cj.save

    j = Job.inject( business_id, payload )

    j.parent_id.should eq( cj.id )

  end 

  it 'should requeue a stalled Bing/SignUp job' do
    site = Site.create(:name => 'Bing')
    b = Business.new
    b.id = 100

    payload = Payload.new
    payload.site = site
    payload.name = 'SignUp'
    payload.client_script = 'client_script'
    payload.data_generator = 'data_generator'
    payload.save

    j = Job.inject( b.id, payload, 10.hours.ago)
    j.start
    j.update_attribute(:waited_at, 20.minutes.ago)

    Job.pending(b)

    FailedJob.count.should eq(1)
    Job.count.should eq(1)

  end

  
end
