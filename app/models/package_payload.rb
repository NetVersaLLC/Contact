class PackagePayload < ActiveRecord::Base
  attr_accessible :description, :package_id, :queue_insert_order, :site_id
  belongs_to :package
  belongs_to :site

  scope :insert_order, -> { order( "queue_insert_order ASC") } 


  def self.by_package(package_id)
    PackagePayload.where(:package_id => package_id).insert_order
  end
end
