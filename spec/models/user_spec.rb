require 'spec_helper'

describe User do 
  it { should have_many :businesses}
  it { should have_one :download }
  it { should belong_to :label }
end
