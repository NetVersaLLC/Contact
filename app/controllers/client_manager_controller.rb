class ClientManagerController < ApplicationController
  before_filter :require_reseller

  respond_to :html, :json

  def index 
    @business = Business.accessible_by(current_ability).where(id: params[:business_id]).first || Business.first
    @businesses = Business.accessible_by(current_ability).order("business_name asc").all
  end 

  def jobs
    class_name = params[:name]
    if class_name == "latest"
      @jobs = []

      business = Business.find(params[:business_id]) 

      PackagePayload.joins(site: [:payloads]).order("sites.name asc").
        where( package_id: business.subscription.package_id).
        select(["sites.name as sname","payloads.name as pname"]).each do |payload|
          fullname = "#{payload.sname}/#{payload.pname}" 

          job = Job.get_latest( business, fullname) 
          job = Job.new( name: fullname, status: 6 ) if job.nil? # missing job 

          @jobs.push job
      end 
    else 
      @jobs = class_name.to_s.classify.constantize.where(business_id:  params[:business_id]).order("position asc")
    end 
  end 

  def booboos 
    @booboos = Booboo.where( business_id: params[:business_id] )
  end 

  private 

  def require_reseller
    unless current_user.reseller? 
      redirect_to "/", error: "Not authorized" 
    end 
  end 

end 
