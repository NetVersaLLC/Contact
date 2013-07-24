class PackagePayload < ActiveRecord::Base
  attr_accessible :description, :package_id, :payload, :site, :queue_insert_order
  belongs_to :package

  scope :insert_order, -> { order( "queue_insert_order ASC, site ASC, payload ASC") } 

  def name
    self.site + '/' + self.payload
  end
end
