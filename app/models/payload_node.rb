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
    unless CompletedJob.where(:business_id => business.id, :name => node.name).count > 0 or Job.where(:business_id => business.id, :name => node.name).count > 0
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
    return nil if business.nil?
    missing = []
    self.recurse_tree(business, self.root, missing)
    STDERR.puts "missing: #{missing.inspect}"
    return missing
  end

  def self.add_missed_payloads(business)
    self.find_missed_payloads(business).each do |payload|
      business.add_job(payload)
    end
  end

  def self.add_recursive(package, parent_id)
    top = PayloadNode.create do |node|
        node.name      = package
        node.parent_id = parent_id
    end
    Payload.children(package).each do |payload|
      self.add_recursive(payload, top.id)
    end
  end

  before_save :default_values
  def default_values
    self.position ||= self.maximum(:position) + 10
  end
end
