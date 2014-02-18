class AddYellowbotNotify < ActiveRecord::Migration
  def up
    p = Payload.new 
    p.site_id = 27 # yellowbot
    p.name = "Notify"
    p.data_generator = "data = {}"
    p.client_script = "#" 
    p.save
  end

  def down
  end
end
