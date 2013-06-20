require 'spec_helper'

describe Subscription do
	it { should have_many :businesses }
	it { should have_many :transaction_events }
	
	it { should belong_to :business }
	it { should belong_to :label }
	it { should belong_to :package }
	it { should belong_to :transaction_events }

	let(:subscription) { FactoryGirl.build(:subscription) }

	it 'is valid with valid attributes' do
		subscription.should be_valid
	end

	describe '#label_id'
		it 'is required' do
			subscription.label_id = nil
			subscription.should have(1).error_on(:label_id)
		end
	end

	describe '#package_id'
	  it 'is required' do
	  	subscription.package_id = nil
	  	subscription.should have(1).error_on(:package_id)
	  end
	end

	describe '#monthly_fee'
		it 'is required' do
			subscription.monthly_fee = nil
			subscription.should have(1).error_on(:monthly_fee)
		end

    it 'has only numeric values' do
   		subscription.monthly_fee = '20.00'
   		subscription.should have(1).error_on(:monthly_fee)
   	end
  end
end

