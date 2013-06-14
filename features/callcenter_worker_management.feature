Feature: Callcenter worker management
  In order to improve user experience
  As a white label owner
  I want to be able to manage users

  Scenario: Sign In
    Given I am not signed in
    When I sign in as a callcenter worker
    Then I should see "Welcome Employee"

  Scenario: Add User
    Given I am signed in as a "reseller"
    And I am on the User Manager page
    When I click "Add User"
    And I enter the user's details
    Then I should see "user added"

  Scenario: Remove User
    Given I am signed in as a "reseller"
    And I am on the User Manager page
    When I click "Remove" next to a user
    Then I should see "User Removed"

  Scenario: User Edit Page
    Given I am signed in as a "reseller"
    And I am on the User Manager page
    When I click "Edit" next to a user
    Then I should see the User Edit page

  Scenario: Change Password
    Given I am signed in as a "reseller"
    And I am on the User Edit page
    When I enter a new password
    And I click "Change"
    Then I should see "Password has been reset"
