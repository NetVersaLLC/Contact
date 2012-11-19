class YelpsController < ApplicationController
  before_filter :authenticate_user!

  def check_email
    business = Business.find(params[:business_id])
    @link = Yelp.check_email(business)
    unless @link.nil?
      Job.create do |j|
        j.user_id = current_user.id
        j.status  = 0
        j.payload = "link='#{@link}'\n"+File.open(Rails.root.join("payloads/yelp/2_click_link.rb")).read
      end
    else
      @job = Job.where('business_id = ? AND status IN (0,1)', business.id).order(:position).first
      @job.status = 0
      @job.save
    end
    @status = { :status => :wait }
    respond_to do |format|
      format.json { render json: @status }
    end
  end

  def yelp_category
    render json: YelpCategory.categories
  end

end
