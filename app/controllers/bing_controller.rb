class BingController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to    :js

  def bing_category
    render json: BingCategory.categories
  end
end
