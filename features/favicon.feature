@active
Feature: Favicons
  In order to allow Labels to have different favicons
  As a label owner
  I would like to be able to upload a favicon

  Scenario: Upload icon
    Given: I am on the My Label page for a reseller.
    When: I upload a favicon.
    Then: I should see the message "Favicon Updated".

  Scenario: View favicon on label
    Given: I have set a favicon for a label.
    When: I view the front-end of the site.
    Then: I should see the favicon set by the label.

  Scenario: View default favicon
    Given: A favicon has not been set by the label.
    When: I view the front-end of the site.
    Then: I should not see a favicon.
