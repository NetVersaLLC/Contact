class Business < ActiveRecord::Base
  include Business::Attributes
  include Business::Validations

  include Business::CitationListMethods
  include Business::FormMethods
  include Business::MiscMethods

  # Associations
  has_attached_file :logo, :styles => { :thumb => "100x100>" }
  validates_attachment :logo,
    :size => { :in => 1..1500.kilobytes }

  has_many          :jobs, :order => "position"
  has_many          :failed_jobs, :order => "position"
  has_many          :completed_jobs, :order => "position"
  belongs_to        :user
  belongs_to        :subscription
  has_many          :notifications
  has_many          :images
  has_one           :transaction_event # transaction that occurred at sign up

  # Triggers
  after_create      :create_site_accounts
  after_create      :create_jobs
  after_initialize  :set_times

  # search on activeadmin -> meta_search 
  scope :redeemed_coupon_eq, lambda { |cid| joins(:transaction_event).
    where(:transaction_events => { :coupon_id => cid })
  }
  search_methods :redeemed_coupon_eq

  # This loads the citation list in Business::CitationList and
  # then creates various data representations from it. This also
  # adds all the associations and defines the nested form code.
  load_citation_list

  # NOTE:
  # so we need to manaully set "class_name"
  # This basically replaces
  # add_nested      :crunchbases
  # After experimenting for a few hours this seemed like the only way to
  # make it work.
  has_many :crunchbases, :dependent => :destroy, :class_name => "Crunchbase"
  attr_accessible :crunchbases_attributes
  accepts_nested_attributes_for :crunchbases, :allow_destroy => true

  #Fix for the Listwns model trying to change it to Listwn.
  has_many :listwns, :dependent => :destroy, :class_name => "Listwns"
  attr_accessible :listwns_attributes
  accepts_nested_attributes_for :listwns, :allow_destroy => true

  #Fix for the Supermedia model trying to change it to Supermedia.
  has_many :supermedia, :dependent => :destroy, :class_name => "Supermedia"
  attr_accessible :supermedia_attributes
  accepts_nested_attributes_for :supermedia, :allow_destroy => true

  #Fix for the Localpages model trying to change it to Localpage.
  has_many :localpages, :dependent => :destroy, :class_name => "Localpages"
  attr_accessible :localpages_attributes
  accepts_nested_attributes_for :localpages, :allow_destroy => true

  #Fix for the Localcensus model trying to change it to Localcensu.
  has_many :localcensus, :dependent => :destroy, :class_name => "Localcensus"
  attr_accessible :localcensus_attributes
  accepts_nested_attributes_for :localcensus, :allow_destroy => true

  #Fix for the Yippie model trying to change it to Yippy.
  has_many :yippies, :dependent => :destroy, :class_name => "Yippie"
  attr_accessible :yippies_attributes
  accepts_nested_attributes_for :yippies, :allow_destroy => true

  #Fix for the Usyellowpages model trying to change it to Usyellowpage.
  has_many :usyellowpages, :dependent => :destroy, :class_name => "Usyellowpages"
  attr_accessible :usyellowpages_attributes
  accepts_nested_attributes_for :usyellowpages, :allow_destroy => true


  def label_id
    self.user.label_id
  end

end
