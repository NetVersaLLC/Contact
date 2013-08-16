require 'spec_helper' 

describe Task do

  it "has a status of 'new' when instantiated" do 
    t = Task.new
    expect(t.status).to eq('new') 
  end 

	it "only allows one open task per business" do
    business = Business.new 
    business.id=1

    t = Task.request_sync(business)

    expect( t.status ).to eq('new') 
    expect( t ).to be_a_kind_of(Task)
    expect( Task.where(business_id: business.id).open.count).to eq(1)
    
    expect( Task.request_sync(business).id ).to eq(t.id)
    expect( Task.where(business_id: business.id).open.count).to eq(1)
  end 

  it "starts existing task and invoke business.create_jobs" do 
    business = Business.new
    business.id = 1 
    business.should_receive(:create_jobs)

    Task.request_sync( business ) 
    Task.start_sync( business ).should be_true
  end 

  it "returns false when there are not any tasks" do 
    business = Business.new
    business.id = 1 

    Task.start_sync( business ).should be_false
  end 

  it "completes a task" do 
    business = Business.new
    business.stub(:create_jobs)
    business.id = 1 

    Task.request_sync( business ) 
    Task.start_sync( business )

    Task.complete(business).should be_true
  end 




end 
