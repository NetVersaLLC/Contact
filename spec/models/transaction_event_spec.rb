require 'spec_helper'

describe TransactionEvent do
	it { should have_many :payments }
	it { should have_many :subscriptions }

	it { should belong_to :business }
	it { should belong_to :coupon }
	it { should belong_to :label }
	it { should belong_to :package }
	it { should belong_to :payment }
	it { should belong_to :subscription }

	let(:transaction_event) { FactoryGirl.build(:transaction_event) }

	it 'is valid with valid attributes' do
		transaction_event.should be_valid
	end

	describe '#label_id' do
		it 'is required' do
			transaction_event.label_id = nil
			transaction_event.should_not be_valid
		end
	end

	describe '#package_id' do
		it 'is required' do
			transaction_event.package_id = nil
			transaction_event.should_not be_valid
		end
	end
end


