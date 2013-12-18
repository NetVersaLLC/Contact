class Payload < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :site
  #belongs_to :mode
  acts_as_tree :order => "position"
  # If this approach would be fine then we can define a class which inhertis form payload and add these columns to that class
  attr_accessible :from_mode, :to_mode

  def save_to_sites
    if Site.where(:id => self.site_id).count == 0
      p self
      return
    end
    STDERR.puts "save_to_sites: Site: #{site}"
    site_dir = Rails.root.join("sites", site.name)
    unless Dir.exists?  site_dir
     Dir.mkdir site_dir
    end
    payload_dir = site_dir.join(self.name)
    unless Dir.exists?  payload_dir
     Dir.mkdir payload_dir
    end
    STDERR.puts "Writing: #{payload_dir}"
    File.open(payload_dir.join("client_script.rb"), "wb") do |f|
      f.write self.client_script
    end 
    File.open(payload_dir.join("data_generator.rb"), "wb") do |f|
      f.write self.data_generator
    end 
  end

  def self.database_to_git
    # First sync payloads
    Payload.where("1 = 1").each do |payload|
      payload.save_to_sites
    end
    # Now remove unused sites
    sites_dir = Rails.root.join("sites")
    Dir.open(sites_dir).each do |site_name|
      next if site_name =~ /^\./
      site_dir = sites_dir.join(site_name)
      next unless File.directory? site_dir
      site = Site.find_by_name(site_name)
      if site == nil
        STDERR.puts "WARNING: Site with name '#{site_name}' does not exist in the database!"
        STDERR.puts "Should I remove it from the git repo?"
        STDERR.print "[y/N]: "
	answer = STDIN.gets.strip
        if answer == 'y'
          FileUtils.rm_rf sites_dir.join(site_name)
          STDERR.puts "Removed..."
        else
          STDERR.puts "Skipping..."
        end
        next
      end
      # And payloads
      Dir.open(site_dir).each do |payload_name|
	payload_dir = site_dir.join(payload_name)
	next if payload_name =~ /^\./
	next unless File.directory? payload_dir.join(payload_name)
        payload = Payload.find_by_name_and_site_id(payload_name, site.id)
	if payload == nil
	  STDERR.puts "WARNING: Payload with name '#{payload_name}' does not exist in the database!"
	  STDERR.puts "Should I remove it from the git repo?"
	  STDERR.print "[y/N]: "
	  answer = STDIN.gets.strip
	  if answer == 'y'
	    FileUtils.rm_rf payload_dir
            STDERR.puts "Removed..."
          else
            STDERR.puts "Skipping..."
          end
	  next
	end
        File.open(payload_dir.join("client_script.rb"), "wb").write payload.client_script
        File.open(payload_dir.join("data_generator.rb"), "wb").write payload.data_generator
      end
    end
    STDERR.puts "Synced to git in sites/"
    STDERR.puts "Please remember to commit this work and resolve any conflicts before you git pull!"
    STDERR.puts "The next step you should take is enter this directory and commit your code and push."
  end

  def self.git_to_database
    sites_dir = Rails.root.join("sites")
    Site.all.each do |site|
      # Is the site in the db but removed by someone in git?
      unless File.directory? sites_dir.join(site.name)
        STDERR.puts "Warning: Someone removed: #{site.name}!"
        STDERR.puts "Should I remove it from the database?"
        STDERR.print "[y/N]: "
        answer = STDIN.gets.strip
        if answer == 'y'
	  site.destroy
          STDERR.puts "Removed..."
        else
          STDERR.puts "Skipping..."
        end
      end
    end
    count = 0
    Dir.open(sites_dir).each do |site_name|
      count += 1
      next if site_name =~ /^\./
      site_dir = sites_dir.join(site_name)
      next unless File.directory? site_dir
      site = Site.find_by_name(site_name)
      if site == nil
        site = Site.create do |site|
          site.name = site_name
        end
      end
      STDERR.puts "#{count}: Site: #{site.name}"
      Dir.open(site_dir).each do |payload_name|
	next if payload_name =~ /^\./
        payload_dir = site_dir.join(payload_name)
	next unless File.directory? payload_dir
        payload = Payload.find_by_name_and_site_id(payload_name, site.id)
	STDERR.puts "#{site.name}/#{payload_name}"
        if payload == nil
          payload = Payload.new
          payload.name = payload_name
	  payload.site_id = site.id
          STDERR.puts "Couldn't find a payload in the db for #{site.name}/#{payload_name}"
          Payload.where(:site_id => site.id).each do |payload|
            STDERR.puts "#{payload.name}: #{payload.id}"
          end
          STDERR.puts "What's the payload parent id for this payload?"
          STDERR.puts "Enter for a root payload (no parent): "
          parent_id = STDIN.gets.strip
          if parent_id != ''
            payload.parent_id = parent_id
          end
          STDERR.puts "Here are the available modes:"
          Mode.all.each do |mode|
            STDERR.puts "Mode: #{mode.name}"
          end
          STDERR.puts "Which mode (by name) should we use?: "
          mode_name = STDIN.gets.strip
          if mode_name != ''
            mode = Mode.find_by_name(mode_name)
            payload.mode_id = mode.id
          end
          payload.save!
          STDERR.puts "Saving: #{payload}.."
        end
	if File.exists? payload_dir.join("client_script.rb")
	  script = File.read payload_dir.join("client_script.rb")
	  payload.client_script = script
	end
	if File.exists? payload_dir.join("data_generator.rb")
	  script = File.read payload_dir.join("data_generator.rb")
	  payload.data_generator = script
	end
	STDERR.puts "Site: #{site}"
        STDERR.puts "Updating: #{payload.site.name}/#{payload.name}: #{payload_dir}...\n";
        payload.save!
      end
    end
  end

  def to_tree
    obj = {
      id: self.id,
      label: self.name,
      isFolder: true,
      open: true,
      checkbox: false,
      radio: false,
      childs: []
    }
    self.children.each do |child|
      obj[:childs].push child.to_tree
    end
    obj
  end

  def self.to_tree(site_id, mode_id)
    ret = []
    self.where(:site_id => site_id, :mode_id => mode_id, :parent_id => nil).each do |payload|
      ret.push payload.to_tree
    end
    ret
  end

  def self.by_name(name)
    site_name, payload_name = *name.split("/")
    site = Site.find_by_name(site_name)
    if site == nil
      return nil
    end
    self.where(:site_id => site.id, :name => payload_name).first
  end

  def self.sites
    Site.pluck(:name).sort
  end

  def self.list(site)
    site = Site.by_name(site)
    self.where(:site_id => site.id).order(:name).pluck(:name).sort
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
    self.by_name(name)
  end

  def self.exists?(site, payload) 
    site = Site.by_name(site)
    self.by_name(name).nil? != true
  end 

  def self.by_site_and_payload(site, payload)
    site = Site.by_name(site)
    self.by_name("#{site}/#{payload}")
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
    mode = Mode.find_by_name("SignUp")
    if node.mode_id != mode.id
      STDERR.puts "Skipping #{node.inspect} since not mode #{mode.id}"
      return
    end
    STDERR.puts "#{id}: #{node.name}: #{missing}"
    STDERR.puts "Node: #{node.inspect}"
    STDERR.puts "Node Child: #{node.children.inspect}"
    site = Site.where(:id => node.site_id).first
    if site == nil
      STDERR.puts "Skipping: #{node.inspect}"
      return
    end
    STDERR.puts "Checking..."
    unless CompletedJob.where(:business_id => business.id, :name => node.name).count > 0 or Job.where(:business_id => business.id, :name => node.name).count > 0
      missing.push "#{site.name}/#{node.name}"
      STDERR.puts "Adding: #{site.name}/#{node.name}..."
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
    mode = Mode.find_by_name("SignUp")
    Payload.where(:parent_id => nil, :mode_id => mode.id).each do |root|
      self.recurse_tree(business, root, missing)
    end
    STDERR.puts "missing: #{missing.inspect}"
    return missing
  end

  def self.add_missed_payloads(business)
    self.find_missed_payloads(business).each do |payload|
      business.add_job(payload)
    end
  end

  before_save :default_values
  def default_values
    self.position ||= self.maximum(:position) + 10
  end

   def self.add_to_jobs(business, name)
     payload = Payload.start(name)
     if payload == nil
       return nil
     end
     @job = Job.inject(business.id, payload.client_script, payload.data_generator, payload.ready)
     @job.name = name
     @job.save!
     @job
   end

end
