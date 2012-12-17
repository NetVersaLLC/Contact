class ActiveRecord::Base

  def self.add_nested(*args)
    args.each do |arg|
      has_many arg, :dependent => :destroy
      accepts_nested_attributes_for arg, :allow_destroy => true
      attr_accessible "#{arg}_attributes".to_sym
    end
  end

  def self.load_citation_list
    site_models = []
    self.citation_list.each do |site|
      model = site[0].constantize
      table = site[1].to_sym
      site_models.push model

      # NOTE: Must skip this due to an invalid inflection
      if table == :crunchbases
        next
      end
      add_nested table
    end
    Business.sub_models = site_models
  end

end
