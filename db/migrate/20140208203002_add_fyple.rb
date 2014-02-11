class AddFyple < ActiveRecord::Migration
  def up
     fyple = Site.new
     fyple.name = "Fyple"
     fyple.domain = "http://www.fyple.com"
     fyple.model = "Fyple"
     fyple.save
     
     Payload.create(site: fyple, name: "SignUp", mode_id: 1, to_mode_id: 2)
     Payload.create(site: fyple, name: "CreateListing", mode_id:2,  to_mode_id: 3)
     Payload.create(site: fyple, name: "UpdateListing", mode_id: 3, to_mode_id: 3)
  end

  def down
  end
end
