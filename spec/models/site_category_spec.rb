require File.dirname(__FILE__) + '/../spec_helper'
 
describe SiteCategory do

  before(:all) do
     @bing_category = FactoryGirl.create(:bing_category3)
     @root_category = BingCategory.where(name: 'root')[0]
  end

  it "non-root instance has parent of same class" do
    @bing_category.parent.class.to_s.should eq 'BingCategory'
  end

  it "instance.walk return should include nested array of its own and children' names, ids" do
    parent = @bing_category.parent
    parent.walk.should eq [parent.name, parent.id, [[@bing_category.name, @bing_category.id]] ]
  end

  it "class.list_categories(node) should be nested hash of its descendent" do
    end_node_hash = { @bing_category.name => @bing_category.id }
    BingCategory.list_categories(@bing_category.parent).should eq end_node_hash
  end

  it "class.categories return should be list_categories(root)" do
    
  end

  it "instance.to_list return should be array ancestors' and own names. " do
    @bing_category.to_list.should eq [@bing_category.parent.name, @bing_category.name]
  end 

  it "instance.tmake_category return should be string of ancestors' and own names, joining by ' > '" do
    @bing_category.make_category.should eq @bing_category.parent.name + ' > ' + @bing_category.name
  end 

  it "class.build_list return should be ... " do
    list = BingCategory.build_list([],  @bing_category)
  end 
  
end
