class BusinessesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @business = Business.find_by_user_id(current_user.id)

  end

  # GET /businesses/1/edit
  def edit
    @business = Business.find_by_user_id(current_user.id)
  end

  # PUT /businesses/1
  # PUT /businesses/1.json
  def update
    @business = Business.find_by_user_id(current_user.id)

    respond_to do |format|
      if @business.update_attributes(params[:business])
        format.html { redirect_to '/home', notice: 'Business was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

end
