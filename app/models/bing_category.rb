class BingCategory < ActiveRecord::Base
  attr_accessible :name, :name_path, :parent_id
  acts_as_tree :order => :name
  belongs_to :google_category
  has_many :bings
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
    if node.children and node.children.count > 0
      node.children.each do |child|
        self.build_list(arr, child)
      end
    else
      arr.push [node.make_category, node.id.to_s]
    end
  end
  def self.list
    arr = []
    self.build_list(arr, BingCategory.root)
    arr
  end

  def self.list_children(node)
    html = '<li><a href="#" class="mymenu" data-cat-id="'+node.id.to_s+'">' + node.name + '</a>'
    if node.children.length > 0
      html += '<ul>'
      node.children.each do |child|
        html += self.list_children(child)
      end
      html += '</ul>'
    end
    html += '</li>'
  end
  def self.build_menu
    self.list_children(BingCategory.root)
  end

  def self.get_id_name
    self.to_s.gsub(/([A-Z])/, '_\1').downcase.gsub(/^_/, '')+'_id'
  end

  def self.make_category(id)
    self.find(id).make_category
  end
end
