Feature: Manage Resellers
  In order to whitelabel the product
  As a label
  I want to be able to manage my accounts and users

  Scenario: Sign up
    Given I am on the sign up page
    And I signup as a reseller 

  Scenario: Signing Up
    Given I am on the sign up page
    When I fill in "Email" with "reseller@somewhitelabel.com"
    And I fill in "Choose a Password" with "12345Xdsu"
    And I fill in "Verify Password" with "12345Xdsu"
    And I click "Sign Up"
    Then I should see "Welcome Reseller"

  Scenario: Account Balance
    Given I have signed in to the admin panel.
    When I am taken to the dashboard.
    Then I should see my account balance.

  Scenario: Sub-Labels
    Given I have signed in to the admin panel.
    When I click on "Labels".
    Then I should see a list of my sub-labels.

  Scenario: 
    Given My label has 1000 credits 
    And  I have a child label with 0 credits
    When I have signed in to the admin panel
    Then I should see 1000 credits for my label 
    And I should see 0 credits for my child label 

  Scenario: 
    Given My label has 1000 credits 
    And  I have a child label with 0 credits
    When I transfer 100 credits to the child label
    Then My label should have 900 credits 
    And The child should have 100 credits 
