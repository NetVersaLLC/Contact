require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "Ezlocal" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "http://ezlocal.com/"
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_ezlocal" do
    @driver.get(@base_url + "/")
    @driver.find_element(:link, "List Your Business").click
    @driver.find_element(:id, "tPhone1").clear
    @driver.find_element(:id, "tPhone1").send_keys "573"
    @driver.find_element(:id, "tPhone2").clear
    @driver.find_element(:id, "tPhone2").send_keys "529"
    @driver.find_element(:id, "tPhone3").clear
    @driver.find_element(:id, "tPhone3").send_keys "2536"
    @driver.find_element(:id, "bSubmit").click
    @driver.find_element(:id, "tBusinessName").clear
    @driver.find_element(:id, "tBusinessName").send_keys "Argyle Industries Intimidy Ltd."
    @driver.find_element(:id, "tPhone1").clear
    @driver.find_element(:id, "tPhone1").send_keys "573"
    @driver.find_element(:id, "tPhone2").clear
    @driver.find_element(:id, "tPhone2").send_keys "529"
    @driver.find_element(:id, "tPhone3").clear
    @driver.find_element(:id, "tPhone3").send_keys "2536"
    @driver.find_element(:id, "tBusinessAddress").clear
    @driver.find_element(:id, "tBusinessAddress").send_keys "2935 Leeway Dr"
    @driver.find_element(:id, "tBusinessAddress2").clear
    @driver.find_element(:id, "tBusinessAddress2").send_keys "Apt C"
    @driver.find_element(:id, "tFax1").clear
    @driver.find_element(:id, "tFax1").send_keys "555"
    @driver.find_element(:id, "tFax2").clear
    @driver.find_element(:id, "tFax2").send_keys "555"
    @driver.find_element(:id, "tFax3").clear
    @driver.find_element(:id, "tFax3").send_keys "2121"
    @driver.find_element(:id, "tBusinessCity").clear
    @driver.find_element(:id, "tBusinessCity").send_keys "Columbia"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "dBusinessState")).select_by(:text, "Missouri")
    @driver.find_element(:id, "tBusinessZip").clear
    @driver.find_element(:id, "tBusinessZip").send_keys "65202"
    @driver.find_element(:id, "tFirstName").clear
    @driver.find_element(:id, "tFirstName").send_keys "Jacob"
    @driver.find_element(:id, "tLastName").clear
    @driver.find_element(:id, "tLastName").send_keys "Argyle"
    @driver.find_element(:id, "tContactPhone1").clear
    @driver.find_element(:id, "tContactPhone1").send_keys "573"
    @driver.find_element(:id, "tContactPhone2").clear
    @driver.find_element(:id, "tContactPhone2").send_keys "529"
    @driver.find_element(:id, "tContactPhone3").clear
    @driver.find_element(:id, "tContactPhone3").send_keys "2536"
    @driver.find_element(:id, "tEmail").clear
    @driver.find_element(:id, "tEmail").send_keys "cnzgizym@blazingdev.com"
    @driver.find_element(:id, "bSubmit").click
    @driver.find_element(:link, "None of these, just a free basic listing.").click
    @driver.find_element(:id, "tDescription").clear
    @driver.find_element(:id, "tDescription").send_keys "Description should go here."
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "dCategory2")).select_by(:text, "Abortion Alternatives")
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "dCategory3")).select_by(:text, "Beer Distributor")
    @driver.find_element(:id, "tWebsite").clear
    @driver.find_element(:id, "tWebsite").send_keys "http://argyle2industriesltd.com"
    @driver.find_element(:id, "fuImage").clear
    @driver.find_element(:id, "fuImage").send_keys "C:\\Users\\jonathan\\Downloads\\me.jpg"
    @driver.find_element(:id, "btnContinue").click
    @driver.find_element(:id, "chkTerms").click
    @driver.find_element(:id, "bFinish").click
    @driver.find_element(:link, "finish and submit your profile.").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "dCategory")).select_by(:text, "Pilates Studio")
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
