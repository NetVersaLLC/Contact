Feature: Subscription Management
  In order to allow customers to have recurring subscriptions.
  As a signed in user
  I want to be able to manage my subscriptions.

  Scenario: Go to sign up page
    Given I am a signed in user
    When I go to the new packages page
    Then I should see a list of packages

  Scenario: Start subscription
    Given I am a signed in user
    And I am on the new packages page
    When I fill "First name" with "Sherlock"
    And I fill "Last name" with "Holmes"
    And I fill in "Address" with "221 Baker St."
    And I fill in "Address2" with "B"
    And I fill in "City" with "London"
    And I select "California" from "State"
    And I fill in "Zip" with "31337"
    And I fill in "Card Number" with "4007000000027"
    And I select "visa" from "Card Type"
    And I select "January" from "Expiration Month"
    And I select "2014" from "Expiration Year"
    And I fill in CVV with "123"
    And I click "Subscribe"
    Then I should see "Subscription Started"