class TestController < ApplicationController
  before_filter      :authenticate_user!
  # skip_before_filter :verify_authenticity_token
  def exception
    raise "Called test:exception!"
  end
end
