Feature: Phone verification
  In order to allow customers to verify phone numbers
  As a business owner
  I want to be able to verify accounts with a phone number

  Scenario: Incoming Verification
    Given I am a customer that has clicked to verify an account
    When I view the verification page
    Then I should see "Start Call"

  Scenario: Verification Started
    Given I am on the verify my account page
    When I click "Start Call"
    Then I should see "You should receive a call in 5-10 minutes"
    And I should see "Code"

  Scenario: Entering Code
    Given I have a code to enter
    When I enter it into "Code"
    And I click "Send"
    Then I should see "Submitting"
    And I should be redirected back to the dashboard
