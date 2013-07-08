require 'qq_file'

class ImagesController < ApplicationController
  before_filter      :authenticate_user!
  skip_before_filter :verify_authenticity_token
  # GET /images.json
  def index
    bid = params[:business_id] 

    @images = Image.where(:business_id => bid).order(:position) 
    @images.each do |img|
      img[:medium] = img.data.url(:medium)
    end
    respond_to do |format|
      format.json { render json: @images }
    end
  end

  # POST /order/1.json
  def order
    @res = {:update => true}
    i = 0
    params[:order].each do |em|
      image          = Image.find(em)
      image.position = i
      i             += 1
      image.save
    end
    render json: @res
  end

  # DELETE /images/1/all.json
  def destroy_all
    Image.where(:business_id => params[:id]).delete_all
    render json: {:success => true}
  end

  # POST /images.json
  def create
    @image ||= Image.new(params[:image])
    position            = Image.where(:business_id => params[:business_id]).maximum(:position) || 0
    position            = position + 1
    @image.position     = position
    @image.display_name = position # if this changes, see Image.reorder_positions 
                                   # not very OOP, but dont know what else will break if I change it
    @image.data         = QqFile.parse(params[:qqfile], request)
    @image.file_name    = @image.data.original_filename
    @image.business_id  = params[:business_id]
    
    @response = {}
    @response[:success] = false 

    # qqfile will be nil if the file upload fails.  
    if( (not params[:qqfile].nil?) && @image.save) 
      Image.column_names.each do |col|
        @response[col] = @image[col]
      end
      @response[:success] = true
      @response[:errors]  = @image.errors
      @response[:thumb]   = @image.data.url(:thumb)
      @response[:medium]  = @image.data.url(:medium)
      respond_to do |format|
        format.json { render :json => @response }
      end
    else 
      respond_to do |format| 
        format.json { render :json => @response, :status => :bad_request }
      end
    end 

  end

  # PUT /images/1
  # PUT /images/1.json
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.json { head :ok }
      else
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    Image.reorder_positions( @image.business_id )    

    @response = {:status => :removed, :image_id => params[:id]}
    respond_to do |format|
      format.json {render :json => @response }
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

  def set_logo
    #if pa
    @image = Image.find_by_id(params[:id])
    Image.where(:business_id => @image.business_id).update_all(:is_logo => false)

    respond_to do |format|
      if @image.update_attributes(:is_logo => true)
        format.json { head :ok }
      else
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
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
