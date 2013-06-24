require 'spec_helper'

describe Payment do
	it { should have_many :transaction_events}
	it { should belong_to :label }
	it { should belong_to :business }
	it { should belong_to :transaction_event }
	
	let(:payment) { FactoryGirl.build(:payment) }

	it 'is valid with valid attributes' do
		payment.should be_valid
	end

	describe '#label_id' do
	  it 'is required' do
	  	payment.label_id = nil
	  	article.should have(1).error_on(:label_id)
	  end
	end

end