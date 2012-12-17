class Business < ActiveRecord::Base
  require(Rails.root.join("lib", "citation_list"))
  include Business::Attributes
  include Business::Validations

  include Business::CitationListMethods
  include Business::FormMethods
  include Business::MiscMethods

  # Associations
  has_attached_file :logo, :styles => { :thumb => "100x100>" }
  has_many          :jobs, :order => "position"
  belongs_to        :user
  belongs_to        :subscription
  has_many          :notifications

  # Triggers
  after_create      :create_citation_list
  after_create      :create_jobs
  after_initialize  :set_times

  # This loads the citation list in Business::CitationList and
  # then creates various data representations from it. This also
  # adds all the associations and defines the nested form code.
  load_citation_list

  # NOTE:
  # Inflector classify()s "crunchases" to Crunchbasis
  # so we need to manaully set "class_name"
  # This basically replaces
  # add_nested      :crunchbases
  # After experimenting for a few hours this seemed like the only way to
  # make it work.
  has_many :crunchbases, :dependent => :destroy, :class_name => "Crunchbase"
  attr_accessible :crunchbases_attributes
  accepts_nested_attributes_for :crunchbases, :allow_destroy => true

end
