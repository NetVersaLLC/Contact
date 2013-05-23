#!/usr/bin/env ruby

# encoding: UTF-8

require 'nokogiri'

outfile_name = File.join('..',  'doc', 'site_data.txt')
outfile = File.open(outfile_name, 'w')
outfile.puts ['file', 'site', 'owner', 'founded', 'alexa_us_traffic_stats', 'rank', 'url','traffic_stats', 'notes'].join('|')

site_profile_html_dir = File.join(ENV['HOME'], 'townc', 'projs', 'sitedata', 'html')

Dir.open(site_profile_html_dir).each do |file|
  next unless file =~ /\.html$/
  ffile = File.join(site_profile_html_dir, file)
  nok = Nokogiri::HTML( File.open(ffile, "r").read )
  site = ''
  owner = ''
  founded = ''
  alexa_us_traffic_rank = ''
  page_rank = '' 
  url = ''
  traffic_stats = '' 
  notes = ''
  text = ''

  nok.xpath("//h1").each do |h1|
    site = h1.inner_text
puts '---------------' + 'site'
  end
  nok.xpath("//body").each do |div|
    text = div.inner_text
    text =~ /^.*Owner\s*-\s*(.*)\s*Founded\s*-\s*/i
      owner = $1 || ''
      owner = owner.rstrip.lstrip  
puts owner
    text =~ /^.*Founded\s*-\s*(.*)\s*Alexa Us Traffic Rank\s*-\s*/i
      founded = $1 || ''
      founded = founded.rstrip.lstrip
puts founded
    text =~ /^.*Alexa Us Traffic Rank\s*-\s*(.*)\s*Page Rank\s*-\s*/i
      alexa_us_traffic_rank = $1 || ''
      alexa_us_traffic_rank = alexa_us_traffic_rank.rstrip.lstrip  
puts alexa_us_traffic_rank
    text =~ /^.*Page Rank\s*-\s*(.*)\s*Url\s*-\s*/i
      page_rank = $1 || ''
      page_rank = page_rank.rstrip.lstrip 
puts page_rank
    text =~ /^.*Url\s*-\s*(.*)\s*Traffic Stats\s*-\s*/i
      url = $1 || ''
      url = url.rstrip.lstrip
puts url
    text =~ /^.*Traffic Stats\s*-\s*(.*)\s*Notes\s*-\s*/i
      traffic_stats = $1 || ''
      traffic_stats = traffic_stats.rstrip.lstrip
puts traffic_stats
    text =~ /^.*Notes\s*-\s*(.*)\s*Sources\s*-\s*/i
      notes = $1 || ''
      notes = notes.rstrip.lstrip
puts notes
  end
  outfile.puts [file, site, owner, founded, alexa_us_traffic_rank, page_rank, url, traffic_stats, notes].join('|')
end



