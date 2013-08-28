class PayloadNode < ActiveRecord::Base
  attr_accessible :active, :broken_at, :name, :notes, :package_id, :parent_id, :position
  acts_as_tree :order => "position"

  def add_child_payload(name)
    child = self.children.create
    child.name = name
    child.parent_id = self.id
    child.save
    STDERR.puts "self.id: #{self.id}"
    return child
  end

  def self.recurse_tree(business, node, missing)
    id = business.nil? ? 'nil' : business.id.to_s
    STDERR.puts "#{id}: #{node.name}: #{missing}"
    STDERR.puts "Node: #{node.inspect}"
    STDERR.puts "Node Child: #{node.children.inspect}"
    STDERR.puts "Checking..."
    if CompletedJob.where(:business_id => business.id, :name => node.name).count == 0 and Job.where(:business_id => business.id, :name => node.name).count == 0
      missing.push node.name
      STDERR.puts "Adding: #{node.name}..."
      return
    end
    STDERR.puts "Checked..."
    node.children.each do |child|
      STDERR.puts "Recurse: #{child.name}"
      self.recurse_tree(business, child, missing)
    end
  end

  def self.find_missed_payloads(business)
    STDERR.puts "find_missing_payloads(#{business.id})"
    return nil if business.nil?
    missing = []
    root = self.root
    PayloadNode.where(:parent_id => 0).each do |p|
      p.parent_id = root.id
      p.save
    end
    self.recurse_tree(business, self.root, missing)
    STDERR.puts "missing: #{missing.inspect}"
    return missing
  end 

  before_save :default_values
  def default_values
    self.position ||= self.maximum(:position) + 10
  end
end
