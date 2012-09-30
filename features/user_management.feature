Feature: User management
  In order to define customer roles.
  As a visitor.
  I want to be able to perform basic user operations.

  Scenario: Go to sign up
    Given I am an anonymous site visitor
    When I click "Sign Up" in upper right
    Then I am taken to the sign up page.

  Scenario: Sign up
    Given I am on the sign up page
    When I fill in "Email" with "test@example.com"
    And I fill in "Password" with "test"
    And I fill in "Password Confirmation" with "test"
    And I click "Sign Up"
    Then I should see "Packages"
