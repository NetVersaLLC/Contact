class ResultsController < ApplicationController
  before_filter :authenticate_user!
  def update
    @job = Job.where(:id => params[:id])
    if @job.count == 0
      @job = Job.new
    end
    respond_to do |format|
      if @job.save_results(params, current_user)
        format.json { render json: {:status => 'ok'} }
      else
        format.json { render json: {:status => 'error'} }
      end
    end
  end

end
