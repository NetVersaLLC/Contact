class Image < ActiveRecord::Base
  has_attached_file :data, :styles => { :thumb => '100x100>', :medium => '240x240>' }
  attr_accessor :thumb, :medium, :url

  validates :business_id,
    :presense => true
  def self.new_tmpfile
    name           = SecureRandom.hex 16
    Rails.root.join('public/system/photos',
                    name[0],
                    name[1],
                    name[2 .. name.length]).to_s
  end

  def process_upload()
    
  end
  def url
    self.data.url()
  end
  def medium
    self.data.url(:medium)
  end
  def thumb
    self.data.url(:thumb)
  end
end
