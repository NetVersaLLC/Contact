class ScanApiController < ApplicationController
  before_filter :authenticate!
  layout nil

  def submit_scan_result
    head :forbidden unless params[:scan] && params[:scan][:id]
    task = Scan.find(params[:scan][:id])
    unless task.task_status == Scan::TASK_STATUS_TAKEN
      head :forbidden
      return
    end
    task.update_attributes(params[:scan].slice(:status, :listed_phone, :listed_address, :listed_url))
    task.task_status = Scan::TASK_STATUS_FINISHED
    task.save!
    head :accepted
  end

  protected

  def authenticate!
    head :forbidden unless params[:token] && Contact::Application.config.scanserver['scan_api_token'] == params[:token]
  end

end
