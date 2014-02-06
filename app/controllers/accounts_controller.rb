class AccountsController < ApplicationController  #InheritedResources::Base
  prepend_before_filter :authenticate_user_from_token!

  #defaults :resource_class => ClientData, :collection_name => 'accounts', :instance_name => 'account'

  #load_and_authorize_resource :only => [:index, :show, :categorize]
  skip_before_filter :verify_authenticity_token

  respond_to :html, :json
  #actions :all

  add_breadcrumb 'Accounts', :accounts_url
  add_breadcrumb 'Edit Account', nil, only: [:edit, :update]

  def index 
    if current_user.admin?
      #@businesses = Business.order('business_name asc')
      business_id = params[:business_id]
    elsif current_user.reseller?
      #@businesses = Business.where(label_id: current_label.id).order('business_name asc')
      business_id = params[:business_id]
    else 
      business_id = current_user.businesses.first.id
    end 

    if business_id.nil?
      @rows = []
    else 
      business = Business.find( business_id )
      authorize! :manage, business
      sites = business.package_payload_sites.join("','") 

      @rows = ActiveRecord::Base.connection.select_all("select client_data.id, client_data.email, client_data.username, client_data.status, client_data.listings_url, client_data.listing_url, client_data.type, client_data.created_at, client_data.updated_at, client_data.category_id, client_data.business_id, client_data.category2_id, client_data.do_not_sync from client_data where client_data.business_id = #{business_id} and type in ('#{sites}') order by type asc ")
    end 
  end

  def update
    @account = ClientData.find(params[:id]) 
    authorize! :update, @account
    @account.update_attributes( params[:account] )
    render 
  end 

  def show 
    @account = ClientData.find(params[:id]) 
    authorize! :read, @account
    render 
  end 

	def create
		business = Business.find( params[:business_id] )
		if current_user.nil? or business.user_id != current_user.id
			redirect_to '/', :status => 403
      return
    end
    model = Business.get_sub_model(params['model'])
    obj = model.where(:business_id => business.id).first
    unless obj
      obj = model.new
      obj.business_id = business.id
    end
    #obj.update_attributes(params[obj.class.name.downcase])
    obj.update_attributes(params['account'])
    obj.save!
		render json: {'status' => 'success'}
	end

  def categorize
    @business = Business.find(params[:business_id])

    sites = Business.citation_list.map{ |d| d[0] } 

    ClientData.descendants.each do |descendant| 
      next unless sites.include?( descendant.name ) 

      account = @business.client_data.where(:type => descendant.name).first
      if account.nil?
        new_account = descendant.new 
        new_account.business_id = @business.id 
        new_account.save  validate: false
      end 
    end 

    render 
  end 

end
