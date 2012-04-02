class YelpsController < ApplicationController
  # GET /yelps
  # GET /yelps.json
  def index
    @yelps = Yelp.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @yelps }
    end
  end

  # GET /yelps/1
  # GET /yelps/1.json
  def show
    @yelp = Yelp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @yelp }
    end
  end

  # GET /yelps/new
  # GET /yelps/new.json
  def new
    @yelp = Yelp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @yelp }
    end
  end

  # GET /yelps/1/edit
  def edit
    @yelp = Yelp.find(params[:id])
  end

  # POST /yelps
  # POST /yelps.json
  def create
    @yelp = Yelp.new(params[:yelp])

    respond_to do |format|
      if @yelp.save
        format.html { redirect_to @yelp, notice: 'Yelp was successfully created.' }
        format.json { render json: @yelp, status: :created, location: @yelp }
      else
        format.html { render action: "new" }
        format.json { render json: @yelp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /yelps/1
  # PUT /yelps/1.json
  def update
    @yelp = Yelp.find(params[:id])

    respond_to do |format|
      if @yelp.update_attributes(params[:yelp])
        format.html { redirect_to @yelp, notice: 'Yelp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @yelp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /yelps/1
  # DELETE /yelps/1.json
  def destroy
    @yelp = Yelp.find(params[:id])
    @yelp.destroy

    respond_to do |format|
      format.html { redirect_to yelps_url }
      format.json { head :no_content }
    end
  end
end
