require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "Foursquare" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://foursquare.com/"
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_foursquare" do
    @driver.get(@base_url + "/search?q=saigon&near=columbia%2C+mo")
    @driver.find_element(:id, "q").clear
    @driver.find_element(:id, "q").send_keys "Assured Development, LLC"
    @driver.find_element(:id, "near").clear
    @driver.find_element(:id, "near").send_keys "Columbia, MO"
    @driver.find_element(:css, "p.translate > input.greenButton.translate").click
    @driver.find_element(:link, "Saigon Bistro").click
    @driver.find_element(:link, "Claim here").click
    @driver.find_element(:link, "Sign up for foursquare").click
    @driver.find_element(:link, "Sign up with Email").click
    @driver.find_element(:id, "firstname").clear
    @driver.find_element(:id, "firstname").send_keys "Snaxxle"
    @driver.find_element(:id, "lastname").clear
    @driver.find_element(:id, "lastname").send_keys "Dorbus"
    @driver.find_element(:css, "#emailWrapper > span.input-holder > span.input-default").click
    @driver.find_element(:css, "#emailWrapper > span.input-holder > span.input-default").click
    @driver.find_element(:id, "userEmail").clear
    @driver.find_element(:id, "userEmail").send_keys "cnzgizym@blazingdev.com"
    @driver.find_element(:name, "F221050266016CQERJO").clear
    @driver.find_element(:name, "F221050266016CQERJO").send_keys "1354snt"
    @driver.find_element(:id, "userPhone").clear
    @driver.find_element(:id, "userPhone").send_keys "15735292536"
    @driver.find_element(:id, "userLocation").clear
    @driver.find_element(:id, "userLocation").send_keys "Columbia"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "F2210502660211XIFK5")).select_by(:text, "November")
    @driver.find_element(:name, "F221050266022QSTXN5").clear
    @driver.find_element(:name, "F221050266022QSTXN5").send_keys "C:\\Users\\jonathan\\Downloads\\me.jpg"
    @driver.find_element(:name, "F221050466023UV1TUH").click
    @driver.find_element(:id, "skip").click
    @driver.find_element(:link, "Continue to the homepage »").click
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
