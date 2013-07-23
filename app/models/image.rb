class Image < ActiveRecord::Base
  has_attached_file :data, 
    :styles => { :thumb => '100x100>', :medium => '240x240>', original: { geometry: "1024x1024>",  processors: [:cropper]  }  }

  attr_accessor :thumb, :medium, :url, :crop_x, :crop_y, :crop_w, :crop_h, :is_crop, :first_crop
  after_update :reprocess_data, if: :is_crop?

  belongs_to :business 
  belongs_to :business_form_edit # this is usually temporary 

  def self.new_tmpfile
    name = SecureRandom.hex 16
    Rails.root.join('public/system/photos',
                    name[0],
                    name[1],
                    name[2 .. name.length]).to_s
  end

  def is_crop?
    self.is_crop.present?
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

  def as_json(options = {})
    super((options || {}).merge({ methods: [:thumb, :medium, :url] }))
  end

  def reprocess_data
    self.data.reprocess!
    self.is_crop = false
  end

  # Because the display name is set from the position, we need to reorder to fill 
  # in any gaps when an image is deleted.  
  #
  # without reorder (1,2,3,4) -> delete position 2 -> (1,3,4)  
  # with reorder    (1,2,3,4) -> delete position 2 -> (1,2,3) 
  #
  def self.reorder_positions( business_id ) 
    return if business_id.blank? 
    
    Image.where(:business_id => business_id).each_with_index do |i, idx| 
      i.display_name = i.position = idx + 1 # zero based 
      i.save
    end 
  end 

end
