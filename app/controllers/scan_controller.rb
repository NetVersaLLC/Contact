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
    resp = ['Citisquare']
    render json: resp
  end
  def site
    @scan = Scan.new(params[:id], params[:name], params[:zip])
    render json: @scan.run()
  end
end
