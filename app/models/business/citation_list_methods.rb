module Business::CitationListMethods
  extend ActiveSupport::Concern
  included do

    def self.ensure_citation_list
      @citation_list = eval( File.read(Rails.root.join("lib", "citation_list.rb"))).sort unless @citation_list
    end

    def self.citation_list
      @citation_list
    end

    def self.site_accounts_by_key
      hash = {}
      self.citation_list.each do |site|
        hash[ site[1] ] = site
      end
      hash
    end

    def nonexistent_accounts
      list = []
      Business.citation_list.each do |site|
        list.push site if self.send(site[1]).count == 0
      end
      list
    end

    def nonexistent_accounts_array
      @accounts = []
      self.nonexistent_accounts.each do |site|
        @accounts.push site[0 .. 1]
      end
      @accounts
    end

    def sites
      list = []
      Business.citation_list.each do |site|
        list.push site if self.send(site[1]).count > 0
      end
      list
    end

    def self.sub_models=(models)
      @site_models = models
    end

    def self.sub_models
      @site_models
    end

    def self.get_sub_model(str)
      Business.sub_models.each do |klass|
        STDERR.puts "Comparing #{str} <=> #{klass.class.to_s}"
        if klass.to_s == str
          return klass
        end
      end
      nil
    end

  end
end
