require 'open-uri'
require 'nokogiri'

namespace :mailcom do
  task :get_domains do
    html = open('http://service.mail.com/registration.html?edition=us&lang=en&device=desktop#.7518-bluestripe_v1423592-element1-1').read
    nok = Nokogiri::HTML(html)
    list = []
    nok.xpath("//select[@class='TopLevelDomain ColouredFocus']//option").each do |option|
      list.push option.inner_text
    end
    puts list.inspect
  end
end
