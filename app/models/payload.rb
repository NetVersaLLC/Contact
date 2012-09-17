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
      payloads.push payload
    end
    payloads.sort
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

  def initialize(site, payload)
    @site_dir       = site
    @payload_dir    = payload
    @ready          = nil
    @shared         = nil
    @payload        = nil
    @data_generator = nil

    sites = Rails.root.join('sites')

    begin
      @shared = File.open( sites.join(@site_dir, 'shared.rb') ).read
    rescue
    end

    begin
      @data_generator_file = sites.join(@site_dir, @payload_dir, 'data_generator.rb')
      if File.exists? @data_generator_file
        @data_generator = File.open(@data_generator_file).read
      end
    rescue
    end

    begin
      @ready_file = sites.join(@site_dir, @payload_dir, 'ready.rb')
      if File.exists? @ready_file
        @ready = File.open(@ready_file).read
      end
    rescue
    end

    begin
      @payload_file = sites.join(@site_dir, @payload_dir, 'client_script.rb')
      if File.exists? @payload_file
        @payload = File.open(@paload_file).read
      end
    rescue
    end
  end
end
