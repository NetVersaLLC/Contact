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
      sites = business.subscription.package.package_payloads.pluck(:site_name)

      Payload.order('position asc').each do |node| 
        next unless sites.include?( node.name.split('/')[0])

        job = Job.get_latest( business, node.name) 
        job = Job.new( name: node.name, status: 6 ) if job.nil? # missing job 
        @jobs.push job
      end 
    else 
      @jobs = class_name.to_s.classify.constantize.where('business_id = ? AND status IN (0,1)', params[:business_id]).order(:position)
    end 
  end 

  def booboos 
    @booboos = Booboo.where( business_id: params[:business_id] )
  end 

end 
