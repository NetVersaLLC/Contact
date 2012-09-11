Feature: Login

  Scenario: Successful login
    Given I am at login page
    When I login as zeljko.filipin@gmail.com
    Then home page should open
      And I should see feedback Signed in successfully.
