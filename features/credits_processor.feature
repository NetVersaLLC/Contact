Feature: Credit Processor Feature 
  In order to have labels use credits 
  I want to be able to purchase, transfer and pay with credits 

  Scenario: Add credits 
    Given I have 0 credits 
    When I add 100 credits 
    Then I should have 100 credits 

  Scenario: Pay with credits 
    Given I have 50 credits 
    When I pay with 1 credit 
    Then I should have 49 credits 

  Scenario: Transfer credits 
    Given I have 75 credits 
    And My child has 0 credits 
    When I transfer 33 credits to a child 
    Then I should have 42 credits 
    And My child should have 33 credits 
