class PackagePayload < ActiveRecord::Base
  attr_accessible :description, :package_id, :payload, :site
  belongs_to :package
  def name
    self.site + '/' + self.payload
  end
end
