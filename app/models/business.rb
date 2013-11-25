class Business < ActiveRecord::Base
  include Business::Attributes
  include Business::Validations

  include Business::CitationListMethods
  include Business::FormMethods
  include Business::MiscMethods

  serialize :temporary_draft_storage
  # Associations

  #has_attached_file :logo, :styles => { :thumb => '100x100>', :medium => '240x240>' }

  belongs_to :user
  belongs_to :subscription
  belongs_to :label
  belongs_to :mode
 
  has_one :transaction_event # transaction that occurred at sign up  #belongs

  has_many :jobs, :order => "position", dependent: :destroy
  has_many :failed_jobs, :order => "position", dependent: :delete_all
  has_many :completed_jobs, :order => "position", dependent: :delete_all
  has_many :codes
  has_many :notifications, dependent: :delete_all  #belongs_to not there in notification.rb
  has_many :images, dependent: :delete_all         #belongs_to not there in image.rb
  has_many :tasks
  has_many :client_data, class_name: "ClientData"

  attr_accessible :images_attributes
  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :client_data, allow_destroy: true

  # Triggers -> moved to BusinessObserver

  # search on activeadmin -> meta_search
  #scope :redeemed_coupon_eq, lambda { |cid| joins(:transaction_event).
  #    where(:transaction_events => {:coupon_id => cid})
  #}
  #search_methods :redeemed_coupon_eq

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

  has_many :manta, :dependent => :destroy, :class_name => "Manta"
  attr_accessible :manta_attributes
  accepts_nested_attributes_for :manta, :allow_destroy => true

  has_many :getfaves, :dependent => :destroy, :class_name => "Getfave"
  attr_accessible :getfave_attributes
  accepts_nested_attributes_for :getfaves, :allow_destroy => true

  has_many :yellowwiz, :dependent => :destroy, :class_name => "Yellowwiz"
  attr_accessible :yellowwiz_attributes
  accepts_nested_attributes_for :yellowwiz, :allow_destroy => true

  has_many :mojopages, :dependent => :destroy, :class_name => "Mojopages"
  attr_accessible :mojopages_attributes
  accepts_nested_attributes_for :mojopages, :allow_destroy => true

  has_many :citydata, :dependent => :destroy, :class_name => "Citydata"
  attr_accessible :citydata_attributes
  accepts_nested_attributes_for :citydata, :allow_destroy => true

  has_many :bizhyws, :dependent => :destroy, :class_name => "Bizhyw"
  attr_accessible :bizhyws_attributes
  accepts_nested_attributes_for :bizhyws, :allow_destroy => true
end
