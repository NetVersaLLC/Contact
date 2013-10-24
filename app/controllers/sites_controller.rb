class SitesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource 
  respond_to :html, :json, :js

  add_breadcrumb 'Site Profiles', :site_profiles_url

  def index
    @q = Site.search(params[:q])
    @site_profiles = @q.result.accessible_by(current_ability).paginate(page: params[:page], per_page: 10).order("site asc")
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
