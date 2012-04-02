class JobsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @job = Job.where(:user_id => current_user.id, :status => 'new')
    if @job.count == 0
      @job = {:status => 'wait'}
    else
      @job = @job.first
      if @job.wait == true
        @job = {:status => 'wait'}
      end
    end

    respond_to do |format|
      format.json { render json: @job }
    end
  end

end
