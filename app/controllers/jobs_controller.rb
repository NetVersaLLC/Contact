class JobsController < ApplicationController
  before_filter      :authenticate_user!
  skip_before_filter :verify_authenticity_token

  # It assumes that list of valid transitions has been shown to user and
  # It triggers a state transition for a website for a specific business which will be infered through current_user
  # It creates a job containing the firest job payload
  # Params: site_id, event
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

  # Update the current job payload and fetch the next
  # Params: job_payload_id, result, messsage
  def next_job_payload
    jp_id= params[:job_payload_id]
    jp_result= params[:result]
    jp= JobPayload.find(jp_id)
    next_step= jp.next(jp_result, params[:message])
    respond_to do |format|
      unless next_step.nil?
        format.json { render json: next_step }
      else
        format.json { render json: {:result=> :error}, status: :unprocessable_entity }
      end
    end
  end

end
