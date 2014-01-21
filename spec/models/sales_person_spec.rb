require 'spec_helper'

describe SalesPerson do 
  it { should belong_to :label }
  it { should belong_to :manager }

  it { should have_many :businesses } 

 
  it "should get businesses that he sold" do 

    sales_person = create(:sales_person)
    business     = create(:business,sales_person_id: sales_person.id) 

    sales_person.businesses.count.should eq(1)
  end 
  it "should not get businesses that he did not sell" do 

    sales_person = create(:sales_person)
    business     = create(:business,sales_person_id: sales_person.id + 1)

    sales_person.businesses.count.should eq(0)
  end 

end

