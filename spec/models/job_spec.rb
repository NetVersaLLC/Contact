require 'spec_helper'

describe Job do
	it { should belong_to :business }
	it { should belong_to :screenshot}
end

