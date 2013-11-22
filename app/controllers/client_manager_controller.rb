class ClientManagerController < ApplicationController

  respond_to :html, :json

  def index 
    @business = Business.find(params[:business_id])
  end 

  def jobs
    class_name = params[:name]
    if class_name == "latest"
      @jobs = []

      business = Business.find(params[:business_id]) 

      PackagePayload.joins(site: [:payloads]).order("sites.name asc").
        where( package_id: 1).
        select(["sites.name as sname","payloads.name as pname"]).each do |payload|
          fullname = "#{payload.sname}/#{payload.pname}" 

          job = Job.get_latest( business, fullname) 
          job = Job.new( name: fullname, status: 6 ) if job.nil? # missing job 

          @jobs.push job
      end 
    else 
      @jobs = class_name.to_s.classify.constantize.where(business_id:  params[:business_id]).order("name asc, position asc")
    end 
  end 

  def booboos 
    @booboos = Booboo.where( business_id: params[:business_id] )
  end 

end 
