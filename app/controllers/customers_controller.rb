class CustomersController < InheritedResources::Base
  defaults :resource_class => Business, :collection_name => 'customers', :instance_name => 'customer'

  respond_to :html, :json
  actions :all

  def index
    raise "Not allowed" if current_user.label_id != current_label.id
    raise "Not allowed" unless current_user.reseller?

    @q = Business.order("business_name asc").search(params[:q])
    @customers = @q.result.accessible_by(current_ability).paginate(page: params[:page], per_page: 10)
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
  #  def customer_params
  #    params.require(:customer).permit(:business_id, :client_checkin, :name)
  #  end
end
