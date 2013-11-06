class LabelsController < ApplicationController
  def index
    @labels = Label.where("1 = 1")
  end
end
