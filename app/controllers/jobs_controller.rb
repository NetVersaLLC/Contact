class JobsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @job = Job.pending(current_user.id)
    if @job == nil
      @job = {:wait => true}
    end
    respond_to do |format|
      format.json { render json: @job }
    end
  end

end
