#!/usr/bin/env ruby
# encoding: utf-8

require 'json'
require 'pp'


data = JSON.parse( File.open("data.js").read )

commands = {}
data.each_key do |key|
  data[key].each_key do |cmd|
    puts cmd
    description = data[key][cmd]['description']
    commands[cmd] = description
  end
end

pp commands
