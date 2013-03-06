class ScanController < ApplicationController
  def index
    @name = params[:name].strip
    @zip  = params[:zip].strip
  end
  def sites
    resp = []
    Business.citation_list.each do |site|
      next unless File.exists? Rails.root.join('sites', site[0], 'SearchListing')
      resp.push site[0]
    end
    resp = %w/Yahoo/ #%w/Bing Yelp Yahoo Ezlocal Justclicklocal Yellowassistance Ebusinesspages Citisquare ShopCity Zippro Yellowee Digabusiness Localizedbiz Showmelocal Expressbusinessdirectory/
    render json: resp
  end
  def site
    @scan = Scan.new(params[:id], params[:name], params[:zip])
    res   = @scan.run()
    model = params[:id].constantize
    bid   = params[:business_id]
    if bid
      business = Business.find(bid)
      count = CompletedJob.find_by_sql("select count(*) from completed_jobs where business_id=#{business.id} and name rlike '^#{model}/';")
      if count[0] > 0
        res[:ran] = true
      else
        res[:ran] = false
      end
    end
    render json: res
  end
end
