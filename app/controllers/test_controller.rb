class TestController < ApplicationController
  def exception
    raise "Called test:exception!"
  end
end
