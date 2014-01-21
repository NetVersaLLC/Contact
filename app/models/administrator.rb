class Administrator < User 

  def labels
    Label.all
  end

  def coupons
    Coupon.all
  end

  def packages
    Package.all
  end

  def business_scope
    Business.all
  end

  def job_scope
    Job.all
  end

  def user_scope
    User.all
  end


end 
