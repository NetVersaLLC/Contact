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

    #Subscription.find( session[:subscription] )
    @business = Business.new
    @accounts = @business.nonexistent_accounts_array

    business_form_edit = BusinessFormEdit.find_or_create_by_user_id( current_user.id )
    
    # A new business should not have an id value yet.  
    if business_form_edit.business_id.nil? 
      @business.attributes = business_form_edit.business_params
    end

    business_form_edit.update_attributes({
      business_id: nil, 
      user_id: current_user.id, 
      subscription_id: session[:subscription] }) 
    @site_accounts = Business.citation_list.map {|x| x[0..1]}

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
  end

  def save_edits
    edit = BusinessFormEdit.find_or_create_by_user_id( current_user.id )
    edit.business_params = params[:business] 
    edit.save
    render :nothing => true
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
      respond_to do |format| 
        format.json { render :json => @business.id } 
      end 
      #redirect_to congratulations_path
    else 
      STDERR.puts @business.errors.inspect
      respond_to do |format| 
        format.html { render "new" } 
        format.json { render @business, :status => 400 } 
      end 
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
    @business = Business.find(params[:business_id].to_i)
    if @business.business_name.nil?
      flash[:notice] = "Error: Please fill out your business profile before you order a report."
      redirect_to edit_business_path(@business)
      return
    end

    name = @business.business_name.downcase.gsub(/[^A-Za-z0-9]/, '_')
    d = DateTime.now
   	format = params[:format] || params['format'] || :xlsx
    case format.to_sym
    when :xlsx
			@file = @business.report_xlsx
			@name = d.strftime("#{name}_%m/%d/%Y.xlsx")
			@type = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" 
    when :pdf
			@file = @business.report_pdf
			@name = d.strftime("#{name}_%m/%d/%Y.pdf")
			@type = "application/pdf" 
    else	
      render :text => 'This format is not supported.'
      return
    end
    send_file(@file,
              :type => @type,
              :disposition => "inline",
              :filename => @name)
  end

end
