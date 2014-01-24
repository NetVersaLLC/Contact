require 'spec_helper'

describe "dashboard/index.html.haml" do
  def sign_in_user(user) 
    create(:label)

    visit new_user_session_path 
    fill_in "EMail", with: user.email 
    fill_in "Password", with: user.password
    click_button "Login"
  end 

  it "displays valid content for a customer service agent" do 
    agent = create(:customer_service_agent) 
    sign_in_user agent

    visit root_path

    # side bar
    expect(page).to have_content("Locations")
    expect(page).to have_content("Users")
    expect(page).to have_content("Accounts")
    expect(page).to have_content("Customers")
    expect(page).to have_content("Billing")
    
    expect(page).not_to have_content("Client Manager")
  end 
end 
