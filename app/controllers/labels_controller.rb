class LabelsController < InheritedResources::Base
  load_and_authorize_resource 

  respond_to :html, :json
  actions :all

  add_breadcrumb 'Labels', :labels_url
  add_breadcrumb 'Edit Label', nil, only: [:edit, :update]

  def index 
    @q = Label.search(params[:q])
    @labels = @q.result.accessible_by(current_ability).order("name asc").paginate(page: params[:page], per_page: 10)
  end 

  protected
    def build_resource_params
      return [] if request.get?

      if can? :update, Label
        [params.require(:label).permit(:name, :legal_name, :domain, :label_domain, :address, :support_email, :support_phone, :custom_css, :login, :password, :logo, :footer, :is_pdf ,:is_show_password, :favicon, :mail_from, :theme, :credit_limit, :package_signup_rate, :package_subscription_rate, :report_email_body, :parent, :available_balance, :report_email_body, :sales_phone, :sales_email, :website_url, :website_name)]
      end 
    end 
  
end
