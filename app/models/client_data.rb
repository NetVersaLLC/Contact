class ClientData < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  self.table_name = "client_data"
  #self.abstract_class = true   # this breaks single table inheritance
  belongs_to      :business
  attr_accessible :force_update, :do_not_sync, :listing_url
  serialize       :secrets, CerebusClient.new
  after_find      :deserialize_attributes
  before_save     :serialize_attributes

  # override this and return false in subclasses that dont have categories 
  def has_categories? 
    true
  end 

  def self.descendants
    ObjectSpace.each_object(Class).select{|klass| klass < self}
  end

  def self.get_sub_object( name, business )
    begin
      m = name.constantize
      m.where(business_id: business.id).first
    rescue
      nil
    end
  end

  def has_existing_credentials?
    return false if new_record?

    password_present = respond_to?(:password) && self.password.present?
    email_present =  respond_to?(:email) && self.email.present?
    username_present = respond_to?(:username) && self.username.present?

    password_present && ( email_present || username_present )
  end 

  def latest_scan
    return @scan if defined? @scan

    r = Report.where(business_id: self.business_id).last
    if r.present?
      @scan = Scan.where(report_id: r.id).where(site_name: self.class.name).last
      #@scan.completed_at = r.updated_at if @scan.present? && @scan.completed_at.nil?
    end

    if (not defined? @scan) || @scan.nil?
      @scan = Scan.new(status: "Scan needed")
    end 

    @scan
  end
  def self.latest_scan( business_id, class_name)
    r = Report.where(business_id: business_id).last
    if r.present?
      scan = Scan.where(report_id: r.id).where(site_name: class_name).last
    end

    if (not defined? scan) || scan.nil?
      scan = Scan.new(status: "Scan needed")
    end 

    scan
  end

  def last_update
    ClientData.last_update( self.business_id, self.class.name )
    #j = CompletedJob.where("business_id=#{self.business_id} AND name LIKE '#{self.class.name}/%'").last
    #p j
    #if j.present?
    #  distance_of_time_in_words_to_now( j.updated_at )
    #else
    #  "Not synced"
    #end 
  end

  def self.last_update( business_id, class_name)
    j = CompletedJob.where("business_id= ? AND name LIKE ?", business_id, class_name + '/%').last
    if j.present?
      j.updated_at
    else
      nil
    end 
  end

  # This reads @@custom_attributes which is generated by the
  # virtual_attr_accessor method. It then records only the mentioned
  # attrs and serilizes them into self.secrets
  def serialize_attributes
    @metadata = {}
    # STDERR.puts "serialize_attributes: #{@attributes.inspect}"
    # STDERR.puts @@custom_attributes.inspect
    # STDERR.puts "class : #{self.class.name.to_s}"
    name = self.class.name.to_s.to_sym
    # STDERR.puts "class : #{name.to_s}"
    if @@custom_attributes[name].is_a?(Hash)
      # STDERR.puts "Is a HASH"
      @@custom_attributes[name].each_key do |sym|
        # STDERR.puts "serialize[#{name}](#{sym}) = #{self.send(sym)}"
        @metadata[sym] = self.send(sym)
      end
      # STDERR.puts "SECRETS: #{@metadata.inspect}"
      self.secrets = @metadata
    else
      # STDERR.puts "Is a forced HASH"
      self.secrets = {:forced => true}
    end
  end

  # This loads the virtual attributes from the hash
  def deserialize_attributes
    # STDERR.puts "deserialize_attributes()"
    # STDERR.puts @@custom_attributes.inspect
    # STDERR.puts "SECRETS: #{self[:secrets]}"
    name = self.class.name.to_s.to_sym
    if @@custom_attributes[name].respond_to? 'each_key'
      # STDERR.puts "Responds to each_key"
      @@custom_attributes[name].each_key do |sym|
        # STDERR.puts "deserialize[#{name}](#{sym}) = #{self[:secrets][sym.to_s]}"
        self.send(sym.to_s+'=', self[:secrets][sym.to_s])
      end
    end
  end

  # This is a class method, which records the custom attrs in a class variable
  # then defines the accessors for the variables on the class.
  def self.virtual_attr_accessor(*args)
    @@custom_attributes ||= {}
    args.each do |sym|
      name = self.to_s.to_sym
      if @@custom_attributes[name].nil?
        @@custom_attributes[name] = {}
      end
      # STDERR.puts "Definding: #{name}: #{sym}"
      @@custom_attributes[name][sym] = nil
    end
    attr_accessor *args
    attr_accessible *args
  end

  def force_update= val
    force_update_will_change!
    @roce_update = Time.now
  end

  def data(business_id)
    {}
  end

  def self.create_or_update(business, *args)
    # STDERR.puts "create_or_update(business)"
    inst = business.send(self.to_s.tableize.to_sym).first
    if inst == nil
      inst = new
      inst.business_id = business.id
      inst.save
    end
    args[0].each_key do |col|
      inst.send("#{col}=".to_sym, args[0][col])
    end
    inst.save!
    inst
  end
end
