class LeadsController < ApplicationController
  before_filter      :authenticate_user!
  skip_before_filter :verify_authenticity_token

  def show
    @business_ids = Business.all.collect do |em|
      em.id
    end
  end
  def create
    business = Business.find(params[:business_id])
    @status = business.post_to_leadtrac
    flash[:notice] = "Posted to business"
    redirect_to '/leads'
  end
end
