 cats = []
File.open("category_first.txt").each do |line|
	cats.push(line)
end
 cats = cats.uniq
 cats = cats.sort

 file = File.open("categoryFinal.txt", "w")
cats.each do |cat|
catty = cat.gsub('[["', '').gsub('"]]','')
puts(catty)
  file.write(catty) 
end

file.close unless file == nil