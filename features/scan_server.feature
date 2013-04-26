Feature: Scan Server
  In order to allow our customers to scan for business results.
  As a visting customer.
  I want to be able to scan my business and find my listing status.

  Scenario: Peform Search
    Given: I am on the main page.
    And: I have entered "The Bathroom Supply" in the Business Name field.
    And: I have entered "92614" in the Zip field.
    And: I have entered "(877) 233-2228" in the Phone field.
    When: I click "Scan"
    Then: I should see "Scanning..."

  Scenario: Get Results
    Given: I have performed a search.
    When: Search results have come back.
    Then: I should see "error", "unlisted", "unclaimed" or "claimed" for each row.

  Scenario: Check Address and Phone
    Given: I have gotten result for my search.
    When: A row in the results is "unclaimed" or "claimed".
    Then: I should see an address and phone.

  Scenario: User Sign Up
    Given: I have gotten results for my search.
    When: I put in my email into "Send Me a More Detailed Report"
    And: I click the "Sign Up" button.
    Then: I should see "Signed up! You will receive a full report in a few minutes."

  Scenario: Report Is Finished
    Given: I have requested a report form the "Send Me a More Detailed Report" page.
    When: I check my email.
    Then: I should see "Here's your business scan report!"
