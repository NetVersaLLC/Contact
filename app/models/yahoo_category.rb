class YahooCategory < ActiveRecord::Base
  attr_accessible :name, :parent_id
  belongs_to      :google_category
  acts_as_tree :order => :name
  has_many        :yahoos
  def self.categories
    cats = {}
    self.all.each do |row|
      if cats[row.catname].nil?
        cats[row.catname] = {}
      end
      cats[row.catname][row.subcatname] = row.id
    end
    cats
  end
  def make_category
    "#{self.catname} > #{self.subcatname}"
  end
end
