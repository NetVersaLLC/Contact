class SiteProfile < ActiveRecord::Base
  attr_accessible :alexa_us_traffic_rank, :founded, :notes, :owner, :page_rank, :site, :traffic_stats, :url, :enabled_for_scan, :enabled, :technical_notes

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
