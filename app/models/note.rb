class Note < ActiveRecord::Base 

  belongs_to :business
  belongs_to :user
  attr_accessible :body, :user_id

end 

