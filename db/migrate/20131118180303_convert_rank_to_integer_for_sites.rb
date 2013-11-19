class ConvertRankToIntegerForSites < ActiveRecord::Migration
  def up
    Site.where("alexa_us_traffic_rank is not null").each{ |s| s.update_attribute( :alexa_us_traffic_rank, s.alexa_us_traffic_rank.gsub(/,/,'')) }

    change_column :sites,  :alexa_us_traffic_rank, :integer
  end

  def down
    change_column :sites,  :alexa_us_traffic_rank, :string
  end
end
