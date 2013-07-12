class Lead
  include HTTParty
  base_uri "http://reports.savilo.com/TownCenter/"

  def initialize(business)
    @business = business
  end

  def post
    params = {}
    Business.columns.each do |col|
      params[col.name] = @business.send(col.name)
    end
    options = { :body => params }
    self.class.post('/leads.php', options)
  end
end
