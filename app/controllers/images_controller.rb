require 'qq_file'

class ImagesController < InheritedResources::Base #ApplicationController
  before_filter      :authenticate_user!
  skip_before_filter :verify_authenticity_token

  belongs_to :business 

  # POST /images.json
  def create
    @image = Image.new
    @image.data         = QqFile.parse(params[:qqfile], request)
    @image.file_name    = @image.data.original_filename
    @image.business_id  = params[:business_id]


    # qqfile will be nil if the file upload fails.  
    if( (not params[:qqfile].nil?) && @image.save) 
      render :create, :content_type => 'text/plain' 
    else 
      respond_to do |format| 
        format.json { render nothing: true, :status => :bad_request }
      end
    end 

  end

  # GET /images/1/name?name=blah
  def name
    @image = Image.find(params[:id])
    @image.display_name = params['name']
    @image.save
    respond_to do |format|
      format.json { head :ok }
    end
  end

  def get_logo
    @image = Image.where(:business_id => params[:business_id], :is_logo => true).first
    respond_to do |format|
      if @image
        format.json { render json: nil }
      else
        format.json { render json: @image }
      end
    end
  end
end
