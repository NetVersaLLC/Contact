Feature: Add business

  Background:
    Given I am logged in as zeljko.filipin@gmail.com

  Scenario: Save without entering data
    When I save changes
    Then Business name should have error can't be blank
      And Local phone should have error Format: 555-555-1212
      And Address should have error can't be blank
      And Business description should have error can't be blank
      And Geographic Areas should have error can't be blank

  Scenario: Save after entering required data
    When I enter Business name 1 in Business name
      And I enter 555-555-1212 in Local phone
      And I enter 1 Address in Address
      And I enter Business description 1 in Business description
      And I enter Worldwide in Geographic Areas
      And I save changes
    Then I should see feedback Business created successfully.
