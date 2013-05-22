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
    # make sure it exists

    Subscription.find( session[:subscription] )

    @business = Business.new
    @accounts = @business.nonexistent_accounts_array
    @tab = "#tab1"

    business_form_edit = BusinessFormEdit.find_or_create_by_user_id( current_user.id )
    
    # A new business should not have an id value yet.  
    if business_form_edit.business_id.nil? 
      @business.attributes = business_form_edit.business_params
    end

    business_form_edit.update_attributes({
      business_id: nil, 
      user_id: current_user.id, 
      subscription_id: session[:subscription] }) 

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

    business_form_edit = BusinessFormEdit.find_or_create_by_user_id( current_user.id )
    if @business.id == business_form_edit.business_id 
      @business.attributes = business_form_edit.business_params
      flash[:notice] = 'Unsaved changes have been found.  Please save or cancel them. ' 
    end

    business_form_edit.update_attributes( {:business_id => @business.id, :business_params => nil, :user_id => current_user.id}) 
    @accounts = @business.nonexistent_accounts_array

    @site_accounts = Business.citation_list.map {|x| x[0..1]}
    render :edit_accounts if params[:key]=='edit_accounts'
  end

  def save_and_validate
    edit = BusinessFormEdit.find_or_create_by_user_id( current_user.id )
    edit.business_params = params[:business] 
    @tab = edit.tab = params[:new_tab]
    edit.save

    @business = Business.new(params[:business] ) 
    @business.valid? 

    @tab = params[:current_tab]
    render  'validate', :layout=>false
  end

  def cancel_change
    BusinessFormEdit.where(:user_id => current_user.id).delete_all
    render :nothing => true
  end 


  # POST /businesses
  # POST /businesses.json
  def create
    bfe = BusinessFormEdit.find_by_user_id(current_user.id) 

    sub = Subscription.find( bfe.subscription_id ) 

    @business = Business.new(params[:business])
    @business.user_id = current_user.id
    @business.label_id = current_label.id
    @business.subscription = sub 
    @tab = params[:current_tab]
    

    if @business.save 
      sub.transaction_event.setup_business(@business) 

      BusinessFormEdit.where(:user_id => current_user.id).delete_all
      redirect_to business_url(@business), :notice => 'Congratulations! Your business profile has been created!' 
    else 
      if params[:current_tab] and params[:current_tab] =~ /tab(\d+)/
        @tab = '#tab' + ($1.to_i + 1).to_s
      end
      render "new"
    end 
  end

  # PUT /businesses/1
  # PUT /businesses/1.json
  def update
    @business = Business.find(params[:id])

    respond_to do |format|
      if @business.update_attributes(params[:business])
        BusinessFormEdit.where(:user_id => current_user.id).delete_all

        format.html { redirect_to @business, :notice => 'Business was successfully updated.' } 
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
