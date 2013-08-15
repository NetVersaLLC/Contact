class AddScanEnabledToSiteprofiles < ActiveRecord::Migration
  class SiteProfile < ActiveRecord::Base 
  end 
  
  def up
    add_column :site_profiles, :enabled_for_scan, :boolean, default: false 

    SiteProfile.reset_column_information

    site_list = %w(Google Yahoo Yelp Bing Facebook Foursquare Cornerstonesworld Citisquare Ebusinesspages Expressbusinessdirectory Getfave Hotfrog Ibegin Insiderpages Localizedbiz Showmelocal Uscity Yellowassistance Zippro)
    site_list.each do |site| 
      say "updating #{site}"
      sp = SiteProfile.where(site: site).first_or_create
      sp.update_attribute( :enabled_for_scan, true) 
    end
  end

  def down
    drop_column :site_profiles, :enabled_for_scan
  end 
end
