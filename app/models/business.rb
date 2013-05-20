class Business < ActiveRecord::Base
  include Business::Attributes
  include Business::Validations

  include Business::CitationListMethods
  include Business::FormMethods
  include Business::MiscMethods

  include Backburner::Performable
  queue "business-manage"

  # Associations

  has_many :jobs, :order => "position"
  has_many :failed_jobs, :order => "position"
  has_many :completed_jobs, :order => "position"
  belongs_to :user
  belongs_to :subscription
  has_many :notifications  #belongs_to not there in notification.rb
  has_many :images         #belongs_to not there in image.rb
  has_one :transaction_event # transaction that occurred at sign up  #belongs

  # Triggers
  after_create      :create_site_accounts, :unless => Proc.new { |o| Rails.env == 'test'}
  after_create      :create_jobs, :unless => Proc.new { |o| Rails.env == 'test'}
  after_initialize  :set_times
  before_destroy :delete_all_associated_records

  # search on activeadmin -> meta_search 
  scope :redeemed_coupon_eq, lambda { |cid| joins(:transaction_event).
      where(:transaction_events => {:coupon_id => cid})
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

  def create_site_accounts
    user_id = self.user.id
    business_id = self.id
    Business.async.create_site_accounts_ex user_id, business_id
  end

  private

  def self.create_site_accounts_ex(user_id, business_id)
    backburner_process = BackburnerProcess.find_or_create_by_user_id_and_business_id(user_id, business_id)
    backburner_process.update_attribute(:all_processes, Business.sub_models.map{|b|b.name}.join(' ') )

    Business.sub_models.each do |klass|
      y = klass.new
      STDERR.puts "Model: #{klass}"
      STDERR.puts "Instance: #{y.inspect}"
      y.business_id = business_id
      y.save
      backburner_process.update_attribute(:processed, backburner_process.processed.to_s + " #{klass}")
    end
  end

  def delete_all_associated_records
    jobs = self.jobs
    completed_jobs = self.completed_jobs
    failed_jobs = self.failed_jobs
    notifications = self.notifications
    images = self.images
    self.transaction_event.destroy unless self.transaction_event.blank?

    jobs.each do |job|
      job.destroy
    end unless jobs.blank?

    completed_jobs.each do |completed_job|
      completed_job.destroy
    end unless completed_jobs.blank?

    failed_jobs.each do |failed_job|
      failed_job.destroy
    end unless failed_jobs.blank?

    notifications.each do |notification|
      notification.destroy
    end unless notifications.blank?

    images.each do |image|
      image.destroy
    end unless images.blank?

  end

end
