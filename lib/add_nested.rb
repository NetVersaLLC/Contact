class ActiveRecord::Base
  def self.add_nested(*args)
    args.each do |arg|
      has_many arg, :dependent => :destroy
      accepts_nested_attributes_for arg, :allow_destroy => true
      attr_accessible "#{arg}_attributes".to_sym
    end
  end
end
