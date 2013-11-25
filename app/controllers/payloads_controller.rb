class PayloadsController < InheritedResources::Base
  respond_to :html, :json
  before_filter      :authenticate_user!
  skip_before_filter :verify_authenticity_token

  def index
    @payload = Payload.by_name(params[:name])
    render :json => @payload
  end

  def show
  end

  def tree
    @data = Payload.to_tree(params[:site_id], params[:mode_id])
    render :json => @data
  end

  def move
    @payload = Payload.find(params[:id])
    if params[:parent_id] == 'null'
      @payload.parent_id = nil
    else
      @parent  = Payload.find(params[:parent_id])
      @payload.parent_id = @parent.id
    end
    @payload.save!
    render :json => {:status => :success}
  end

  def destroy
    @payload = Payload.by_name(params[:payload])
    @payload.destroy
    render :json => {:status => :success}
  end

  def create
    @payload = Payload.new(payload_params)
    site = Site.find_by_name(params[:site])
    if site.nil?
      render :json => {:status => :error, :messsage => "Could not find site: #{params[:site]}" }
    else
      @payload.name = params[:name]
      @payload.site_id = site.id
      @payload.save!
      render :json => {:status => :success, :id => @payload.id, :name => @payload.name}
    end
  end

  def save
    @payload = Payload.by_name(params[:name])
    @payload.update_attributes!(payload_params)
    render :json => {:status => :success}
  end

  private

    def payload_params
      params.require(:payload).permit(:name, :parent_id, :client_script, :data_generator, :signature, :position, :ready, :site_id, :active, :broken_at, :notes)
    end
end
