class Payload
  attr_accessor :payload, :ready, :data_generator, :shared

  def self.sites
    sites = []
    path = Rails.root.join("sites")
    Dir.open( path ).each do |site|
      next if site =~ /^\./
      next unless File.directory? path.join(site)
      sites.push site
    end
    sites.sort
  end

  def self.list(site)
    payloads = []
    Dir.open( Rails.root.join("sites", site) ).each do |payload|
      next if payload =~ /^\./
      STDERR.puts "Examining: #{site}/#{payload}"
      next unless File.directory? Rails.root.join("sites", site, payload)
      payloads.push payload
    end
    payloads.sort
  end

  def self.children(name)
    site, payload = *name.split("/")
    children = []
    File.open(Rails.root.join("sites", site, payload, "client_script.rb")).read.scan(/self.start\s*\(?\s*["']([^'"]+)["']/).each do |match|
      next if match[0] == name
      children.push match[0]
    end
    children
  end

  def self.all
    all = []
    Payload.sites.each do |site|
      Payload.list(site).each do |payload|
        all.push Payload.new(site, payload)
      end
    end
    all
  end

  def self.start(name)
    site, payload = *name.split("/")
    inst = new(site,payload)
  end

  def self.exists?(site, payload) 
    File.exists?( Rails.root.join('sites', site, payload) )
  end 

  def initialize(site, payload)
    @site_dir       = site
    @payload_dir    = payload
    @ready          = nil
    @shared         = nil
    @payload        = nil
    @data_generator = nil

    STDERR.puts "Payload: #{site}/#{payload}"
    raise ArgumentError, "Site or payload cannot be nil" if site == nil or payload == nil

    sites = Rails.root.join('sites')
    unless File.exists?( sites.join(site) )
      raise ArgumentError, "Site does not exist: #{site}"
    end
    unless File.exists?( sites.join(site,payload) )
      raise ArgumentError, "Payload does not exist: #{site}/#{payload}"
    end

    begin
      # @shared = File.read( sites.join(@site_dir, 'shared.rb') )
      File.open(sites.join(@site_dir, 'shared.rb'), "r:utf-8") do |f|
        @shared= f.read
      end
    rescue Exception => e
      # STDERR.puts "Shared: #{e}"
    end

    begin
      @data_generator_file = sites.join(@site_dir, @payload_dir, 'data_generator.rb')
      if File.exists? @data_generator_file
        File.open(@data_generator_file, "r:utf-8") do |f|
          @data_generator = f.read
        end
      end
    rescue Exception => e
      # STDERR.puts "Data generator: #{e}"
    end

    begin
      @ready_file = sites.join(@site_dir, @payload_dir, 'ready.rb')
      if File.exists? @ready_file
        File.open(@ready_file, "r:utf-8") do |f|
          @ready = f.read
        end
      end
    rescue Exception => e
      # STDERR.puts "Ready: #{e}"
    end

    begin
      @payload_file = sites.join(@site_dir, @payload_dir, 'client_script.rb')
      if File.exists? @payload_file
        @payload = File.open(@payload_file, "r:utf-8").read
        if @shared
          @payload = @shared + "\n" + @payload
        end
      end
    rescue Exception => e
      # STDERR.puts "Payload: #{e}"
    end
  end
end
