require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "Mapquest" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://listings.mapquest.com/"
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_mapquest" do
    @driver.get(@base_url + "/apps/listing")
    @driver.find_element(:name, "firstName").clear
    @driver.find_element(:name, "firstName").send_keys "Jonathan"
    @driver.find_element(:name, "lastName").clear
    @driver.find_element(:name, "lastName").send_keys "Jeffus"
    @driver.find_element(:name, "phone").clear
    @driver.find_element(:name, "phone").send_keys "573 529 2536"
    @driver.find_element(:name, "email").clear
    @driver.find_element(:name, "email").send_keys "jonathan@blazingdev.com"
    @driver.find_element(:css, "span.btn-var-inner").click
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
end
