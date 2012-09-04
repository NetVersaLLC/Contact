class PayloadCategory < ActiveRecord::Base
  attr_accessible :name, :position
  has_many :payloads
  def self.next_position
    if PayloadCategory.count == 0
      1
    else
      PayloadCategory.order(:position).last.position + 1
    end
  end
end
