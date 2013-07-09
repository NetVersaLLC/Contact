class GoogleCategoriesController < ApplicationController
  before_filter      :authenticate_user!
  # skip_before_filter :verify_authenticity_token
  def show
    query       = params[:id]
    categories  = GoogleCategory.arel_table
    @categories = GoogleCategory.where(categories[:name].matches("%#{query}%")).limit(100)
    @results = []
    @categories.each do |cat|
      @results.push cat.name
    end
    render json: @results
  end
end
