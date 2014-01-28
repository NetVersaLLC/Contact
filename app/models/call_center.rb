class CallCenter < ActiveRecord::Base 

  attr_accessible :name, :label_id

  belongs_to :label

  has_many :managers
  has_many :customer_service_agents

  def leaderboard 
    # TODO rewrite this!
    sales_people_ids = managers.includes(:sales_people).map{|m| m.sales_people.pluck(:id)}.flatten.join(",")
    ActiveRecord::Base.connection.select_all(
      "select users.first_name, users.last_name, count(businesses.id) as sold_count 
      from businesses 
      inner join users on users.id = businesses.sales_person_id
      where businesses.created_at > '#{Time.now.beginning_of_month.to_date}' and sales_person_id in (#{sales_people_ids}) 
      group by sales_person_id")
  end 
end 