class UserAgent < ActiveRecord::Base
  attr_accessible :agent

  def self.get
    UserAgent.offset(rand(UserAgent.count)).first
  end
end
