class RenameMerchantcircleCategories < ActiveRecord::Migration
  def up
    MerchantcircleCategory.all.each do |c| 
      if c.children.first.present? && c.name != 'root'
        c.update_attribute(:name, "#{c.name} -->")
      end
    end 
  end

  def down
    MerchantcircleCategory.all.each do |c| 
      if c.children.present? 
        c.update_attribute(:name, c.name.gsub( / -->\z/, "") )
      end 
    end 
  end
end
