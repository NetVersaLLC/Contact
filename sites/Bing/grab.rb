#!/usr/bin/env ruby

require 'watir-webdriver'

def sign_in( business )
  @browser.goto( 'https://login.live.com/' )
  @browser.text_field( :name, 'login' ).set  business[ 'hotmail' ]
  @browser.text_field( :name, 'passwd' ).set business[ 'password' ]
  # @browser.checkbox( :name, 'KMSI' ).set
  @browser.button( :name, 'SI' ).click
end

def goto_listing( business )
  @browser.goto( 'http://www.bing.com/businessportal/' )
  @browser.link( :text , 'Sign In Here').click

  Watir::Wait::until do
    @browser.div( :text, 'LISTINGS' ).exists?
  end

  @browser.div( :class, 'LiveUI_Area_Items_Repeating' ).div( :text, business['name'] ).click
end

def enter_business_portal_details( business )
  Watir::Wait::until do
    @browser.div( :text, 'YOUR BUSINESS INFORMATION' ).exists?
  end

  # .. Select business category
  @browser.div( :class, 'LiveUI_Area_Category' ).text_field().focus
  # Can't find the way to click on a first search result, so click on 1st category without searching
  # @browser.div( :class, 'LiveUI_Area_Browse_and_Search' ).text_field().set business[ 'category' ]
  # @browser.send_keys :enter
  Watir::Wait::until do
    @browser.div( :class, /Hierarchy_Item/ ).exists?
  end

  @browser.div( :class, 'Hierarchy_HH_MidClosed' ).click

  puts @browser.html
  # <div class="Hierarchy_HH_Standard Hierarchy_HH_MidClosed"></div>
end

@browser = Watir::Browser.new

data = {
  'hotmail' => 'snarfsnarf@live.com',
  'password' => '..7,R%jj',
  'name' => 'Geisha',
  'city' => 'Columbia',
  'state_short' => 'MO'
}

sign_in(data)
goto_listing(data)
enter_business_portal_details(data)

# <input style="position: absolute; display: block; width: 221px; height: 15px; left: 200px; top: 0px; background-color: rgb(255, 255, 255); background-repeat: no-repeat; border: 1px solid rgb(179, 179, 179); text-align: left; font-family: Arial; font-weight: normal; text-decoration: none; color: rgb(0, 0, 0); font-size: 13px;" name="BLBP||Skin||Main||_CONTENT||_MANAGE||Manage_Content||Local Business Manage||Sub Content||Area1||Category||Category - Field" id="BLBP||Skin||Main||_CONTENT||_MANAGE||Manage_Content||Local Business Manage||Sub Content||Area1||Category||Category - Field" class="LiveUI_Field_Input" type="Text">
