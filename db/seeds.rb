# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Added by Refinery CMS Pages extension
# Refinery::Pages::Engine.load_seed


Label.new(:name=>'TownCenter', :domain=>'towncenter.com').save(:validate=>false)

Package.new(:name=>'Starter', :price=>99.99, 
  :short_description => "This is the short description, it's meant to be one or two sentences.",
  :description => "This is the long description of this package. It can contain HTML and could be several pages if that made sense.")
  .save(:validate=>false)

Mode.create do |c|
  c.name = 'SignUp'
  c.description = 'Initial client mode'
end
Mode.create do |c|
  c.name = 'Update'
  c.description = 'Triggered when client goes into update mode.'
end
Mode.create do |c|
  c.name = 'Delist'
  c.description = 'Initial client mode'
end
