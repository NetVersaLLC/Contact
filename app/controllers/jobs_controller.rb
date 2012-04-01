class JobsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @job = Job.where(:user_id => current_user.id, :status => 'new')
    if @job.count == 0 or @job.wait == true
      @job = {:status => 'wait'}
    end

    respond_to do |format|
      format.json { render json: @job }
    end
  end

end
