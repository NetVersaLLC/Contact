class BusinessesController < InheritedResources::Base
  load_and_authorize_resource 
  respond_to :html #,:xml, :json
  actions :all

  add_breadcrumb 'Locations', :businesses_url
  add_breadcrumb  'New Location', '', only: [:new, :create]
  add_breadcrumb  'Edit Location', '', only: [:edit, :update]

  def index 
    @q = Business.search(params[:q])
    @businesses = @q.result.includes(:user).accessible_by(current_ability).paginate(page: params[:page], per_page: 5)
  end 

  def show 
      show! { add_breadcrumb @business.business_name, nil}
  end 


  def tada
    @business  = Business.find(params[:id])
    if @business.user_id != current_user.id
      redirect_to root_path
      return
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
  def update
    @business = Business.find(params[:id]) 
    authorize! :edit, @business 
 
    @business.update_attributes( params[:business] ) 
    @business.temporary_draft_storage = nil
    update! 
  end 

  def edit 
    @business = Business.find(params[:id]) 
    authorize! :edit, @business 
    @business.update_attributes( @business.temporary_draft_storage ) if @business.temporary_draft_storage.present?
    edit!
  end 

  def save_draft
    business = Business.find(params[:id]) 
    authorize! :edit, business 

    business.update_attribute( :temporary_draft_storage, params[:business] )

    respond_to do |format| 
      format.json { head :no_content}  
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
