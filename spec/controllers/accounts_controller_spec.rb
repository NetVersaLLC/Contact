require File.dirname(__FILE__) + '/../spec_helper'

describe AccountsController do
  describe "POST #create" do

    it 'should not fail' do
      business = FactoryGirl.create(:business)
      post :create, :auth_token => business.user.authentication_token, :business_id => business.id, :account => {:password => 'testpass'}, :model => 'Aol'
      response.status.should == 200
    end

  end
end