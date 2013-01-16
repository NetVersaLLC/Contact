@browser.goto(data['url'])
	if @chained
		self.start("Hyplo/Verify")
	end
true
