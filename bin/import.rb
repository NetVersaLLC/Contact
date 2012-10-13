require 'csv'
require './config/environment.rb'
map = {}

CSV.open(ARGV.shift).each do |row|
  map[ row[0] ] = row[1]
end

cols = nil
CSV.open(ARGV.shift).each do |row|
  cols = row if cols == nil
  b = Business.new
  row.each_with_index do |i,e|
    if map[cols[i]].nil?
      next
    end
    b.send("#{map[cols[i]]}=", e)
  end
  b.save :validate => false
end
