class Reward < ActiveRecord::Base 

  belongs_to :administrator

  attr_accessible :points 

  scope :this_week, -> { where("created_at > '#{Time.now.beginning_of_week.to_date}'")}

  def self.leaderboard 
    this_week.select("administrator_id, sum(points) as total_points").group(:administrator_id)
  end 

end 
