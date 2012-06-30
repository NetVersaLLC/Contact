require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "Posting" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://accounts.craigslist.org/"
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_posting" do
    @driver.get(@base_url + "/login")
    @driver.find_element(:link, "new posting").click
    @driver.find_element(:css, "input[type=\"submit\"]").click
    @driver.find_element(:xpath, "(//input[@name='id'])[10]").click # Community category
    @driver.find_element(:xpath, "(//input[@name='id'])[4]").click # General Community category
    @driver.find_element(:id, "U2FsdGVkX18yNDc0MjQ3NGm3w7blmN7QsCYzQyo-ctsKks8hhIgDuZBkLbNJzK0eTnk2CgU9Bm0").clear
    @driver.find_element(:id, "U2FsdGVkX18yNDc0MjQ3NGm3w7blmN7QsCYzQyo-ctsKks8hhIgDuZBkLbNJzK0eTnk2CgU9Bm0").send_keys "Cliff Campbell's Summer Chess Program"
    @driver.find_element(:id, "U2FsdGVkX18yNDc0MjQ3NKVEbYRj-pt69OoyNr5P0Uj-TPp8nicGly_hLlLo-799u-yrIMsIgkNyZUBNcuoyVA").clear
    @driver.find_element(:id, "U2FsdGVkX18yNDc0MjQ3NKVEbYRj-pt69OoyNr5P0Uj-TPp8nicGly_hLlLo-799u-yrIMsIgkNyZUBNcuoyVA").send_keys "Winchester, VA"
    @driver.find_element(:name, "U.2FsdGVkX18yNDc0MjQ3NKyfieGd_ELpH9M1xhziMO43wKl-m1bdLQ6ZXJDwBlysfvyVUVhe:Cdc").clear
    @driver.find_element(:name, "U.2FsdGVkX18yNDc0MjQ3NKyfieGd_ELpH9M1xhziMO43wKl-m1bdLQ6ZXJDwBlysfvyVUVhe:Cdc").send_keys "This summer, every Friday and Saturday from 2pm to 8pm there is open chess in the downtown walking mall in Winchester, VA.  The location is between Daily Grind and the \"Old Court House\" (Currently a Museum).  Free to play, free lessons given.  Learn from masters, sharpen your skills, or just play for fun."
    @driver.find_element(:name, "go").click
    @driver.find_element(:name, "go").click
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
