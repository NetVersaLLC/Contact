class PackagesPayloads < ActiveRecord::Base
  attr_accessible :description, :name, :package_id, :payload, :site
end
