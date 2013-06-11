Feature: CRM Propagation
  In order to allow customers to manage sales leads
  As a label owner
  I want to be able to get data into my CRM

  Scenario: Incoming Scan
    Given I have a customer conducting a scan
    When they start the scan
    Then their business name, phone and zip should be added to my CRM

  Scenario: Starting Order
    Given I have a customer purchasing a package
    When they check out
    Then their full business information should be added to my CRM
