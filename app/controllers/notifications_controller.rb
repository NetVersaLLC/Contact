class NotificationsController < InheritedResources::Base
  #before_filter :authenticate_user!
  load_and_authorize_resource 

  respond_to :html, :json
  actions :all
  belongs_to :business

  protected
    def collection
      @notifications = end_of_association_chain.accessible_by(current_ability).includes(:business).paginate(page: params[:page])
    end 

#  def destroy
#    Notification.find(params[:id]).delete
#    render json: true
#  end

end
