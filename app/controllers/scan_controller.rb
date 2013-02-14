class ScanController < ApplicationController
  def index
    @name = params[:name].strip
    @zip  = params[:zip].strip
  end
  def sites
    name = params[:name].strip
    zip  = params[:zip].strip
    if name and zip and name =~ /^.+$/ and zip =~ /^\d\d\d\d\d(?:-\d\d\d\d)?$/
      parameters = {:eqs => name, :z => zip}.to_query
      url = "http://getlisted.org/snapshot.aspx?#{parameters}"
      html = open(url).read
      nok = Nokogiri::HTML(html)
      res = ''
      nok.xpath("//div[@id='main']").each do |div|
        res = div.inner_html
      end
      res.gsub!(/"images/, '"http://getlisted.org/images')
      resp = {:html => res}
    else
      resp = {:html => '', :error => 'Missing parameters'}
    end
    render json: resp
  end
  def site
  end
end
