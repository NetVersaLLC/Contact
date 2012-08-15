class Provider
  def self.get(name)
    entries = {
      "yelp" => Yelp
    }
    entries[name]
  end
end
