class Site < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection #strong parameters 
  
  STATS_CACHE_KEY = "sites_stats_cache"

  def self.enabled_percent 
    ratio = Site.connection.select_all("select sum(if(enabled,1,0)) / count(id) as 'enabled_ratio' from sites;").first
    ratio['enabled_ratio'].round(2) * 100
  end 

  def self.disabled_percent 
    100 - enabled_percent 
  end 

  has_attached_file :logo, styles: { :thumb => "32x32>" }, default_url: "/assets/missing_logo.jpg"

  attr_accessible :logo
  attr_accessible :alexa_us_traffic_rank, :founded, :notes, :owner, :page_rank, :name, :traffic_stats, :domain, :enabled_for_scan, :enabled, :technical_notes

  has_many :payloads

  def self.by_name(name)
    Site.where(:name => name).first
  end

  def self.get(site)
    site = self.where(:site => site).first
    if site == nil
      return ''
    end
    html = '<table><tbody>'
    html += '<tr><td>'
    html += "Alexa Rank:</td><td> #{site.alexa_us_traffic_rank}</td>" if site.alexa_us_traffic_rank and site.alexa_us_traffic_rank != ''
    html += '</tr>'
    html += '<tr><td>'
    html += "Owner:</td><td> #{site.owner}</td>" if site.owner and site.owner != ''
    html += '</tr>'
    html += '<tr><td>'
    html += "Founded:</td><td> #{site.founded}</td>" if site.founded and site.founded != ''
    html += '</tr>'
    html += '<tr><td>'
    html += "Page Rank:</td><td> #{site.page_rank}</td>" if site.page_rank and site.page_rank != ''
    html += '</tr>'
    html += '<tr><td>'
    html += "Traffic Stats:</td><td> #{site.traffic_stats}</td>" if site.traffic_stats and site.traffic_stats != ''
    html += '</tr>'
    html += '<tr><td>'
    html += "Notes:</td><td> #{site.notes}</td>" if site.notes and site.notes != ''
    html += '</tr>'
    html += '</tbody></table>'
    return html
  end
end
