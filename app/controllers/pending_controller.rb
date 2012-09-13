class PendingController < ApplicationController
  def index
    @jobs = Job.pending
  end
end
