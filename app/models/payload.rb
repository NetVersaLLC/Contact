class Payload < ActiveRecord::Base
  belongs_to :site
  belongs_to :mode
  attr_accessible :client_script, :ready, :data_generator, :shared
  attr_accessible :active, :broken_at, :name, :notes, :package_id, :parent_id, :position
  acts_as_tree :order => "position"

  def self.by_name(site, name)
    self.where(:site_id => site.id, :name => name).first
  end

  def self.sites
    Site.pluck(:name).sort
  end

  def self.list(site)
    site = Site.by_name(site)
    self.where(:site_id => site.id).pluck(:name).sort
  end

  def self.children(name)
    site, payload = *name.split("/")
    site = Site.by_name(site)
    self.where(:site_id => site.id, :name => payload).children.pluck(:name).collect { |name| "#{site.name}/#{name}" }
  end

  def self.all
    all = []
    Payload.sites.each do |site|
      Payload.list(site).each do |payload|
        all.push payload
      end
    end
    all
  end

  def self.start(name)
    site, payload = *name.split("/")
    site = Site.by_name(site)
    self.by_name(site, payload)
  end

  def self.exists?(site, payload) 
    site = Site.by_name(site)
    self.by_name(site, payload).nil? != true
  end 

  def initialize(site, payload)
    site = Site.by_name(site)
    self.by_name(site, payload)
  end

  def add_child_payload(name)
    child = self.children.create
    child.name = name
    child.parent_id = self.id
    child.save
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
    top = Payload.create do |node|
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
