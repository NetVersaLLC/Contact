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
    @business  = Business.find(params[:id])
    if @business.user_id != current_user.id
      redirect_to root_path
      return
    end
    @accounts  = @business.nonexistent_accounts_array
    @job_count = Job.where(:business_id => @business.id, :status => 0).count
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
    if @business.user_id != current_user.id
      redirect_to root_path
      return
    end
    @accounts = @business.nonexistent_accounts_array
    if @business == nil
      redirect_to new_business_path()
    elsif @business.user_id != current_user.id
      redirect_to '/'
    end
  end

  def save_state
    business = Business.where(:user_id=>current_user.id, :status => 0).first
    if business.nil?
      business = Business.new(params[:business])
      business.user = current_user
      business.label = current_label
    else
      #business.update_attributes(params[:business])
      business.attributes = params[:business]
    end
    if business.save(:validate => false)
      render :text => "Data saved.".to_json
    else
      render :text => "Data not saved.".to_json
    end
  end
  

  # POST /businesses
  # POST /businesses.json
  def create
    @business = Business.new(params[:business])
    @business.user_id = current_user.id
    @business.label_id = current_label.id
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

  def report
    @business = Business.find(params[:business_id])
    if @business.business_name.nil?
      flash[:notice] = "Error: Please fill out your business profile before you order a report."
      redirect_to edit_business_path(@business)
      return
    end
    @file = @business.report
    name = @business.business_name.downcase.gsub(/[^A-Za-z0-9]/, '_')
    d = DateTime.now
    name = d.strftime("#{name}_%m/%d/%Y.xlsx")
    send_file(@file,
              :type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
              :disposition => "inline",
              :filename => name)
  end
end
