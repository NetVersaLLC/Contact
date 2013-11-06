class CouponsController < ApplicationController
  before_filter :authenticate_user!
  has_scope :label_match, :type => :boolean

  def new
    @coupon = Coupon.new
  end

  def index
    @coupons = current_user.coupons
  end

  def edit
  end

  def show
    @coupon = Coupon.find(params[:id])
  end

  def update
    @coupon = Coupon.find(params[:id])
  end

  private

    def label_id_match
      @coupon.label_id = current_user.label_id
    end

end
