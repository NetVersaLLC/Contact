class CreateSiteProfiles < ActiveRecord::Migration
  def change
    create_table :site_profiles do |t|
      t.string :site
      t.string :owner
      t.string :founded
      t.string :alexa_us_traffic_rank
      t.string :page_rank
      t.string :url
      t.string :traffic_stats
      t.string :notes

      t.timestamps
    end
  end
end
