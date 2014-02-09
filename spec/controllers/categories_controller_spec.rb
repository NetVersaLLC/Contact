require File.dirname(__FILE__) + '/../spec_helper'

describe CategoriesController do
  describe "handles authorizations" do
    it 'should allow an admin' do 
      business = FactoryGirl.create(:business)
      administrator = create(:administrator) 
      sign_in :user, administrator

      get :index, {business_id: business.id}

      response.status.should == 200
    end 
    it 'should allow a reseller' do
      business = FactoryGirl.create(:business)
      reseller = create(:reseller) 
      sign_in :user, reseller

      get :index, {business_id: business.id}

      response.status.should == 200
    end

    it 'should allow a manager' do 
      business = FactoryGirl.create(:business)
      manager = create(:manager) 
      sign_in :user, manager 

      get :index, {business_id: business.id}

      response.status.should == 200 
    end 

    it 'should not allow a sales person' do 
      business = FactoryGirl.create(:business)
      sales_person = create(:sales_person) 
      sign_in :user, sales_person 

      get :index, {business_id: business.id}

      response.status.should == 302 
    end 

    it 'should not allow a business owner' do 
      business = FactoryGirl.create(:business)
      sign_in :user, business.user

      get :index, {business_id: business.id}

      response.status.should == 302 
    end 
  end
end

