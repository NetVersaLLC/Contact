Feature: Add business

  Scenario: Save without entering data
    Given I am logged in as zeljko.filipin@gmail.com
    When I save changes
    Then Business name should have error can't be blank
      And Local phone should have error Format: 555-555-1212
      And Address should have error can't be blank
      And Business description should have error can't be blank
      And Geographic Areas should have error can't be blank
