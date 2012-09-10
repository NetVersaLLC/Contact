# before all
require "bundler/setup"
require "page-object"
require "page-object/page_factory"
require "rspec-expectations"
require "watir-webdriver"

World(PageObject::PageFactory)

BASE_URL = "http://citation.netversa.com/"
PASSWORD = "6kN@WMCO"

Before do
  @browser = Watir::Browser.new
end

After do
  @browser.close
end
