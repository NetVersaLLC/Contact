require 'json'

body = File.open("categories.json", 'r').read
    categories = JSON.parse(body) 

    categories.each_pair do |root,sub|
    puts(root)
        sub.each_pair do |root2, sub2|
          puts(" > " +root2.to_s)
          next if sub2.to_s == ""
          sub2.each do |sub3|
            puts(" > > " + sub3)
          end


        end

    end