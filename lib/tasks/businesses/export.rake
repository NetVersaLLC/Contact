#!/usr/bin/env ruby

namespace :businesses do
  task :export, :bid do |t,args|
    eval "require './config/environment.rb'"
    eval "require 'json'"
    Rails.application.eager_load!
    b = Business.find args[:bid]
    values = []
    Business.citation_list.each do |data|
      model = data[0].constantize
      obj = model.where(:business_id => b.id).first
      site = Site.find_by_model(data[0])
      next if obj == nil
      hash = { :model => data[0] }
      data[2].each do |row|
        next if row[0] =~ /select/
        value = obj.send(row[1])
        if row[1] =~ /email|username/ and value != nil and value != ''
          hash[row[1]] = value
        elsif row[1] =~ /password/ and value != nil and value != ''
          hash[row[1]] = value
        end
      end
      hash['login_url'] = site.login_url
      values.push hash
    end
    File.open("#{b.id}.json", "w").write values.to_json
  end
end
