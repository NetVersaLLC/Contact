require File.dirname(__FILE__) + '/../spec_helper'
 
describe ClientData do

  before(:all) do
     @bing = FactoryGirl.create(:bing1)
  end
  
 {"email"=>"abc@abc.com", "password"=>"1234", "secret_answer"=>"hello"}
  context "password and secret_answer are set" do
    it "it serialize_attributes" do
      @bing.secrets.keys.should include('password')
      @bing.secrets.keys.should include('secret_answer')
    end
  end

  context "password and secret_answer are set" do
    it "it deserialize_attributes" do
      @bing.deserialize_attributes['password'].should eq nil
      @bing.deserialize_attributes['secret_answer'].should eq nil
    end
  end

  it "class method virtual_attr_accessor to create instance accessible attribute" do
    something = 'something'
    Bing.virtual_attr_accessor(something.to_sym)
    @bing.respond_to?(something).should be true
  end
  
  context "attribute 'something' already added to Bing class" do
    it "class method create_or_update create bing with attibute arguments" do
      args = {"email"=>"abc@abc.com", "password"=>"1234", "secret_answer"=>"abcd", "something"=>"hello"}
      business = FactoryGirl.create(:business1)
      business.bings.should eq []
      Bing.create_or_update(business, args)
      same_business = Business.find(business.id)
      same_business.bings[0].email.should eq "abc@abc.com"
      the_secrets = {"password"=>"1234", "secret_answer"=>"abcd",  "something"=>"hello"}
      same_business.bings[0].secrets.should eq the_secrets
    end
  end

end
