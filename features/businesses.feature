Feature: Add business

  Scenario: Save without entering data
    Given I am logged in as zeljko.filipin@gmail.com
    When I save changes
    Then Business name element should have error can't be blank
