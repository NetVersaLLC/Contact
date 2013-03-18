Feature: Manage Resellers
  In order to whitelabel the product
  As a label
  I want to be able to manage my accounts and users

  Scenario: Signing Up
    Given: I am on the sign up page
    When: I fill in "Email" with "reseller@somewhitelabel.com"
    And: I fill in "Password" with "12345Xdsu"
    And: I fill in "Verify Password" with "12345Xdsu"
    And: I click "Sign Up"
    Then: I should see "Welcome Reseller"
