class ClientData < ActiveRecord::Base
  self.abstract_class = true
  belongs_to      :business
  attr_accessible :force_update
  serialize       :secrets, CerebusClient.new
  after_find      :deserialize_attributes
  before_save     :serialize_attributes

  # This reads @@custom_attributes which is generated by the
  # virtual_attr_accessor method. It then records only the mentioned
  # attrs and serilizes them into self.secrets
  def serialize_attributes
    @metadata = {}
    STDERR.puts "serialize_attributes: #{@attributes.inspect}"
    STDERR.puts @@custom_attributes.inspect
    STDERR.puts "class : #{self.class.name.to_s}"
    name = self.class.name.to_s.to_sym
    @@custom_attributes[name].each_key do |sym|
      @metadata[sym] = self.send(sym)
    end
    STDERR.puts "SECRETS: #{@metadata.inspect}"
    self.secrets = @metadata
  end

  # This loads the virtual attributes from the hash
  def deserialize_attributes
    STDERR.puts "deserialize_attributes()"
    STDERR.puts @@custom_attributes.inspect
    STDERR.puts "SECRETS: #{self[:secrets]}"
    name = self.class.name.to_s.to_sym
    @@custom_attributes[name].each_key do |sym|
      self.send(sym.to_s+'=', self[:secrets][sym.to_s])
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
      STDERR.puts "Definding: #{name}: #{sym}"
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
