require 'spec_helper'

describe CostCenter do
	describe "Associations" do
    it { should belong_to(:label) }

		it { should have_many(:managers) }
    it { should have_many(:customer_service_agents)}
  end 
end 

