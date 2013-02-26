require 'qq_file'

class ImagesController < ApplicationController
  # GET /images.json
  def index
    @images    = Image.where(:business_id => params[:id]).order(:position)
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
    position            = Image.where(:business_id => params[:business_id]).maximum(:position) || 1
    position            = position + 1
    @image.position     = position
    @image.display_name = position
    @image.data         = QqFile.parse(params[:qqfile], request)
    @image.file_name    = @image.data.original_filename
    @image.business_id  = params[:business_id]
    @success            = @image.save

    @response = {}
    Image.column_names.each do |col|
      @response[col] = @image[col]
    end
    @response[:success] = @success
    @response[:errors]  = @image.errors
    @response[:thumb]   = @image.data.url(:thumb)
    @response[:medium]  = @image.data.url(:medium)
    respond_to do |format|
      format.json { render :json => @response }
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
end
