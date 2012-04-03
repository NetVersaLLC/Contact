class YelpCategory < ActiveRecord::Base
  acts_as_tree :order => :name
  belongs_to :business
  def to_list
    res = []
    anc = self.ancestors
    anc.pop
    anc.reverse.each do |an|
      res.push an.name
    end
    res.push self.name
    res
  end
  def make_category
    self.to_list.join(" > ")
  end
  def self.build_list(arr,node)
    if node.children.count > 0
      node.children.each do |child|
        self.build_list(arr, child)
      end
    else
      arr.push [node.make_category, node.id.to_s]
    end
  end
  def self.list
    arr = []
    self.build_list(arr, YelpCategory.root)
    arr
  end
end
