class CouponsController < ApplicationController
  before_filter :authenticate_user!
  has_scope :label_match, :type => :boolean

  def new
    @coupon = Coupon.new
  end

  def index
    @coupons = Coupon.all
  end

  private

    def label_id_match
      @coupon.label_id = current_user.label_id
    end

end