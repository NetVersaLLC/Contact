require 'spec_helper'

describe Label do
	describe "Associations" do
		it { should have_many(:businesses) }
		it { should have_many(:users) }
		it { should have_many(:cost_centers) }
  end 
end 


