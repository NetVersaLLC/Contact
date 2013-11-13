class CouponsController < InheritedResources::Base
  before_filter :authenticate_user!
  has_scope :label_match, :type => :boolean

  def index
    @coupons = current_user.coupons
  end

  def create 
    @coupon = Coupon.new(params[:coupon])
    @coupon.label = current_label
    create!
  end 

  private

    def label_id_match
      @coupon.label_id = current_user.label_id
    end

end
