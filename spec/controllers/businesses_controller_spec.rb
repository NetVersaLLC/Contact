require File.dirname(__FILE__) + '/../spec_helper'

describe BusinessesController do
  describe "GET #search" do

    it 'customer service agent only gets businesses in a cost center' do
      label = create(:label) 

      cc = create(:call_center, label_id: label.id)
      agent = create(:customer_service_agent, call_center_id: cc.id, label_id: label.id)

      FactoryGirl.create(:business, call_center_id: cc.id,   label_id: label.id)
      FactoryGirl.create(:business, call_center_id: cc.id+1, label_id: label.id)

      sign_in :user, agent

      get  :search

      assigns[:businesses].count.should eq(1)
    end

  end
end

