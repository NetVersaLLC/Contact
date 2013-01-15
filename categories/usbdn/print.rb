require 'json'
require 'yaml'

cats = JSON.parse( File.open("cats_second.json").read )

cats.each do |cat|
    puts "#{cat[1]}: "
    cat[2].each do |sub|
        puts " -> #{sub[1]}"
        sub[2].each do |bal|
          puts " -> -> #{bal[1]}"
        end
    end
end
