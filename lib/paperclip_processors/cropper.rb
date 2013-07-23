module Paperclip
  class Cropper < Thumbnail
    def transformation_command
      puts "************************#{ @attachment.instance.inspect }*********************88\n\n\n\n\n\n\n"
      target = @attachment.instance
      if target.try(:is_crop?)
        target.is_crop, target.first_crop = false, true
        puts "--------------------------------------------\n\n\n\n#{ super.inspect }" 
        ["-crop", "#{target.crop_w}x#{target.crop_h}+#{target.crop_x}+#{target.crop_y}" ] +  super.join(' ').sub(/ -crop \S+/, '').split(' ')
      else
        puts "its in the else #{ target.first_crop.blank? }"
        super if target.first_crop.blank?
      end
    end
  end
end
