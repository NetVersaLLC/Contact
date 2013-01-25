
file = File.open("finalCategories.txt", "w")

File.open("categories.txt", 'r').each do |line|

/<option value=\".*\">(.*?)<\/option>/.match(line)
puts($1)

file.write($1 + "\n")

end
file.close unless file == nil