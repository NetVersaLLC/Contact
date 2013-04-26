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

