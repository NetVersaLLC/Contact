class JobsController < ApplicationController
  before_filter      :authenticate_user!
  skip_before_filter :verify_authenticity_token

  # It assumes that list of valid transitions has been shown to user and
  # One of those valid transition has been selected ...
  def create
    site_id, event= params[:site_id], params[:event]
    business= current_user.businesses.first
    bss= BusinessSiteState.find_by_site_id_and_business_id(site_id, business.id)
    job= bss.fire_event event
    respond_to do |format|
      unless job.nil?
        format.json { render json: job }
      else
        format.json { render json: job.errors, status: :unprocessable_entity }
      end
    end
  end

end
