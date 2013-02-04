class SiteCategory < ActiveRecord::Base
  self.abstract_class = true
  def self.list_categories(node)
    return nil if node == nil
    present = {}
    node.children.each do |child|
      if child.children and child.children.count > 0
        present[child.name] = self.list_categories(child)
      else
        present[child.name] = child.id
      end
    end
    present
  end
  def self.categories
    self.list_categories(self.root)
  end
  def self.blist_categories(node)
    node = self.root if node == nil
    present = {}
    node.children.each do |child|
      present[child.name] = child.id
    end
    present
  end
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
    self.build_list(arr, self.root)
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
    self.list_children(self.root)
  end

  def self.get_id_name
    self.to_s.gsub(/([A-Z])/, '_\1').downcase.gsub(/^_/, '')+'_id'
  end

  def self.make_category(id)
    self.find(id).make_category
  end
end
