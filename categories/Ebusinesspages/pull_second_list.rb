



file = File.new("first_pass.txt", "r")

allthestuff = []

while (line = file.gets)
	allthestuff.push(line)
end


finalfile = File.new("final_list.txt", "w")
allthestuff.uniq.each do |thecats|

	finalfile.write(thecats) 

end

