class AccountsController < InheritedResources::Base
  defaults :resource_class => ClientData, :collection_name => 'accounts', :instance_name => 'account'

  load_and_authorize_resource :only => [:index, :show, :categorize]
  skip_before_filter :verify_authenticity_token

  respond_to :html, :json
  actions :all

  add_breadcrumb 'Accounts', :accounts_url
  add_breadcrumb 'Edit Account', nil, only: [:edit, :update]

  def index 
     @q = ClientData.where(:business_id => current_user.businesses.first.id).search(params[:q])
     @accounts = @q.result.accessible_by(current_ability).paginate(page: params[:page], per_page: 10)
  end

	def create
		business = Business.find( params[:business_id] )
		if current_user.nil? or business.user_id != current_user.id
			redirect_to '/', :status => 403
      return
    end
    #STDERR.puts "HERE IS THE MODEL: "+params['model'].to_s
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

    ClientData.descendants.each do |descendant| 
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
