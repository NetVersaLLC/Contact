class BusinessesController < ApplicationController
  before_filter :authenticate_user!

  # GET /businesses/1
  # GET /businesses/1.json
  def show
    @business = Business.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @business }
    end
  end

  # GET /businesses/new
  # GET /businesses/new.json
  def new
    @business = Business.new

    unless current_user.business.nil?
      redirect_to edit_business_path(current_user.business)
    else
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @business }
      end
    end
  end

  # GET /businesses/1/edit
  def edit
    if current_user.business.nil?
      redirect_to new_business_path()
    elsif params[:id].to_i != current_user.business.id
      redirect_to '/'
    else
      @business = Business.find(params[:id])
    end
  end

  # POST /businesses
  # POST /businesses.json
  def create
    if current_user.business.nil?
      @business = Business.new(params[:business])

      respond_to do |format|
        if @business.save
          current_user.business_id = @business.id
          current_user.save
          format.html { redirect_to @business, notice: 'Created your business profile.' }
          format.json { render json: @business, status: :created, location: @business }
        else
          format.html { render action: "new" }
          format.json { render json: @business.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to edit_business_path(current_user.business)
    end
  end

  # PUT /businesses/1
  # PUT /businesses/1.json
  def update
    @business = Business.find(params[:id])

    respond_to do |format|
      if @business.update_attributes(params[:business])
        format.html { redirect_to @business, notice: 'Business was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.json
  def destroy
    @business = Business.find(params[:id])
    @business.destroy

    respond_to do |format|
      format.html { redirect_to businesses_url }
      format.json { head :no_content }
    end
  end
end
