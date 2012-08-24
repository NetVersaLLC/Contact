class BusinessesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @businesses = Business.where(:user_id => current_user.id)
    if @businesses.count == 0
      redirect_to new_business_path()
    elsif @businesses.count == 1
      redirect_to business_path(@businesses.first)
    end
  end

  # GET /businesses/1
  # GET /businesses/1.json
  def show
    @business = Business.find(params[:id])
    @accounts = @business.nonexistent_accounts_array
  end

  # GET /businesses/new
  # GET /businesses/new.json
  def new
    @business = Business.new
    @accounts = @business.nonexistent_accounts_array

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @business }
    end
  end

  # GET /businesses/1/edit
  def edit
    @business = Business.find(params[:id])
    @accounts = @business.nonexistent_accounts_array
    if @business == nil
      redirect_to new_business_path()
    elsif @business.user_id != current_user.id
      redirect_to '/'
    end
  end

  # POST /businesses
  # POST /businesses.json
  def create
    @business = Business.new(params[:business])
    @business.user_id = current_user.id
    respond_to do |format|
      if @business.save
        format.html { redirect_to @business, notice: 'Created your business profile.' }
      else
        logger.info @business.errors.inspect
        format.html { render action: "new" }
      end
    end
  end

  # PUT /businesses/1
  # PUT /businesses/1.json
  def update
    @business = Business.find(params[:id])

    respond_to do |format|
      if @business.update_attributes(params[:business])
        format.html { redirect_to '/businesses', notice: 'Business was successfully updated.' }
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
    if @business and @business.user_id == current_user.id
      @business.destroy
    end

    respond_to do |format|
      format.html { redirect_to businesses_url }
      format.json { head :no_content }
    end
  end
end
