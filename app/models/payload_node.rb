class PayloadNode < ActiveRecord::Base
  attr_accessible :active, :broken_at, :name, :notes, :package_id, :parent_id, :position
  acts_as_tree :order => "position"

  before_save :default_values
  def default_values
    self.position ||= self.maximum(:position) + 10
  end
end
