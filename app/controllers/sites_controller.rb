class SitesController < ApplicationController
  before_filter :authenticate_user!

  # GET /site_profiles
  # GET /site_profiles.json
  def index
    @site_profiles = Site.all
  end

  # GET /site_profiles/1
  # GET /site_profiles/1.json
  def show
  end

  # GET /site_profiles/new
  def new
    @site_profile = Site.new
  end

  # GET /site_profiles/1/edit
  def edit
  end

  # POST /site_profiles
  # POST /site_profiles.json
  def create
    @site_profile = Site.new(site_profile_params)

    respond_to do |format|
      if @site_profile.save
        format.json { render action: 'show', status: :created, location: @site_profile }
      else
        format.json { render json: @site_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /site_profiles/1
  # PATCH/PUT /site_profiles/1.json
  def update
    @site_profile = Site.find(params[:id])
    respond_to do |format|
      if @site_profile.update_attributes(params[:site_profile])
        format.json { head :no_content }
      else
        format.json { render json: @site_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_profiles/1
  # DELETE /site_profiles/1.json
  def destroy
    @site_profile = Site.find(params[:id])
    @site_profile.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

end
