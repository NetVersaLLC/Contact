class Reseller < User 
  def labels
    Label.where(:id => self.label_id)
  end
  def coupons
    Coupon.where(:label_id => self.label_id)
  end

  def packages
    Package.where(:label_id => self.label_id)
  end

  def business_scope
    Business.where(:label_id => self.label_id)
  end

  def job_scope
    Job.where('id is not null')
  end

  def user_scope
    User.where(:label_id => self.label_id)
  end

end 
