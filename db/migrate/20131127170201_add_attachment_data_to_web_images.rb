class AddAttachmentDataToWebImages < ActiveRecord::Migration
  def self.up
    change_table :web_images do |t|
      t.attachment :data
    end
  end

  def self.down
    drop_attached_file :web_images, :data
  end
end
