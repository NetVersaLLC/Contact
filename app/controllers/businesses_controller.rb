class BusinessesController < InheritedResources::Base
  load_and_authorize_resource 
  respond_to :html #,:xml, :json
  actions :all

  def index 
    @q = Business.search(params[:q])
    @businesses = @q.result.accessible_by(current_ability).paginate(page: params[:page], per_page: 5)
  end 

  # def index
  #   flash.keep
  #   @businesses = Business.where(:user_id => current_user.id)
  #   if @businesses.count == 1
  #     b = @businesses.first 

  #     if !b.subscription.active || b.subscription.active.nil?
  #       Notification.add_activate_subscription b
  #     end 

  #     if b.is_client_downloaded
  #       redirect_to business_path(b) 
  #     else 
  #       redirect_to edit_business_path(b)
  #     end 
  #   end
  # end

  # GET /businesses/1
  # GET /businesses/1.json
  # def show
  #   @business  = Business.find(params[:id])
  #   if @business.user_id != current_user.id
  #     redirect_to root_path
  #     return
  #   end
  #   @accounts  = @business.nonexistent_accounts_array
  #   @job_count = Job.where(:business_id => @business.id, :status => 0).count
  # end

  def tada
    @business  = Business.find(params[:id])
    if @business.user_id != current_user.id
      redirect_to root_path
      return
    end
  end 
  

  # GET /businesses/new
  # GET /businesses/new.json
  def new
    # make sure it exists

    #Subscription.find( session[:subscription] )
    @business = Business.new
    #@accounts = @business.nonexistent_accounts_array

    #@site_accounts = Business.citation_list #.map {|x| x[0..1]}

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
    @site_accounts = Business.citation_list #.map {|x| x[0..1]}
    respond_to do |format|
      format.html { render @business.is_client_downloaded ? 'edit' : 'new' } 
      format.json { render json: @business }
    end
  end


  def client_checked_in 
    b = Business.find(params[:id])
    checked_in = b.client_checkin.nil? ? 'no':'yes'
    render :json => checked_in
  end 

  # POST /businesses
  # POST /businesses.json
  def create
    @business = Business.new(params[:business])
    @business.user_id = current_user.id
    @business.label_id = current_label.id
    @business.subscription = sub 
    
    if @business.save 
      sub.transaction_event.setup_business(@business) 

      respond_to do |format| 
        format.json { render :json => @business.id } 
      end 
      #redirect_to congratulations_path
    else 
      STDERR.puts @business.errors.inspect
      respond_to do |format| 
        format.html { render "new" } 
        format.json { render :json => @business, :status => 400 } 
      end 
    end 
  end

  # PUT /businesses/1
  # PUT /businesses/1.json
  def update
    @business = Business.find(params[:id])

    respond_to do |format|
      @business.attributes = params[:business] 

      #if @business.update_attributes(params[:business])
      if @business.save( :validate =>  !request.xhr?)
        format.html { redirect_to @business, :notice => 'Business was successfully updated.' } 
        format.json { head :no_content }
      else
        @accounts = @business.nonexistent_accounts_array
        @site_accounts = Business.citation_list #.map {|x| x[0..1]}

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
      #@business.destroy
      LabelProcessor.new(current_label).destroy_business(@business)
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
#			@file = @business.report_pdf
      @file = PdfReport.generate_pdf(@business)
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
