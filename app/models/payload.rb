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

    STDERR.puts "Site: #{site}"
    STDERR.puts "Payload: #{payload}"

    sites = Rails.root.join('sites')

    begin
      @shared = File.open( sites.join(@site_dir, 'shared.rb') ).read
    rescue Exception => e
      STDERR.puts "Shared: #{e}"
    end

    begin
      @data_generator_file = sites.join(@site_dir, @payload_dir, 'data_generator.rb')
      if File.exists? @data_generator_file
        @data_generator = File.open(@data_generator_file).read
      end
    rescue Exception => e
      STDERR.puts "Data generator: #{e}"
    end

    begin
      @ready_file = sites.join(@site_dir, @payload_dir, 'ready.rb')
      if File.exists? @ready_file
        @ready = File.open(@ready_file).read
      end
    rescue Exception => e
      STDERR.puts "Ready: #{e}"
    end

    begin
      @payload_file = sites.join(@site_dir, @payload_dir, 'client_script.rb')
      if File.exists? @payload_file
        @payload = File.open(@payload_file).read
      end
    rescue Exception => e
      STDERR.puts "Payload: #{e}"
    end
  end
end
