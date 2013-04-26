Feature: Subscription Form
  In order to allow customers to manage subscriptions.
  As a user.
  I want to be able to make purchases and alter subscription status.

  Background:
    Given a label exists called "My Label"
    And a package exists called Starter with a price of "19" and a subscription cost of "5"
    And a package exists called Professional with a price of "299" and a subscription cost of "19"
    And a coupon exists with the code "50OFF" that has the value of "50"
    And a coupon exists with the code "100OFF" that has the value of "100"

  Scenario: Display Prices
    Given I have selected the Starter package
    When I view the page
    Then I should see "19" for the price
    And I should see "5" for the subscription fee
    And I should see "19" for the total

  Scenario: Half Off Coupon
    Given I have selected the Starter package
    And I have applied the "50OFF" coupon
    When I view the page
    Then I should see "19" for the price
    And I should see "5" for the subscription fee
    And I should see "11" for the total

  Scenario: Free Product
    Given I have selected the Professional package
    And I have applied the "100OFF" coupon
    When I view the page
    Then I should see "299" for the price
    And I should see "0" for the subscription fee
    And I should see "0" for the total

  Scenario: Ordinary Purchase
    Given I have selected the Starter package
    And I have entered "Test User" into Name
    And I have entered "370000000000002" into Card Number
    And I have selected "January (01)" in Card Month
    And I have selected "2020" in Card Year
    And I have entered "3278" in CVV
    And I have entered "newuser@domain.com"
    And I have entered "12345678" in Password
    And I have entered "12345678" in Password Confirmation
    And I have checked I Agree
    When I click "Place Order"
    Then I should see "Purchase Complete"
    And a new user should exist
    And they should have an active subscription
    And they should receive a welcome email
    And the label should have 1 fewer credit

  Scenario: Callcenter Form
    Given I have selected the starter package
    And I am visiting the callcenter form
    When I view the page
    Then I should not see Password or Password Confirmation

  Scenario: Callcenter Purchase
    Given I have selected the starter package
    And I am visiting the callcenter form
    And I have filled out the checkout form
    When I click "Place Order"
    Then I should see "Order Complete"
    And I should be on the business form
    And the customer should receive a welcome email with an auto-generated password
    And the label should have 1 fewer credit

  Scenario: Deactive Subscription
    Given I have an active subscription
    And I am visting the subscription edit page
    When I click "Cancel Subscription"
    And I click "Yes" to the "Are you sure?" message
    Then I should see "Subscription Cancelled"
    And I should be on the business profile page

  Scenario: View Activate Subscription
    Given I am on the business profile page
    And the subscription is not currently active
    When I click "Renew Subscription"
    Then I should see the checkout form
    And it should not have "Terms of Service", "Email", "Password" or "Password Confirmation"

  Scenario: Activate Subscription
    Given I have clicked "Renew Subscription"
    When I enter valid checkout information
    And I click "Renew Subscription"
    Then I should see "Subscription Renewed"
    And I should be on the business profile page

  Scenario: Bad Credit Card
    Given I have selected the Starter package
    And I have entered "Test User" into Name
    And I have entered "370000100100002" into Card Number
    And I have selected "January (01)" in Card Month
    And I have selected "2020" in Card Year
    And I have entered "3278" in CVV
    And I have entered "newuser@domain.com"
    And I have entered "12345678" in Password
    And I have entered "12345678" in Password Confirmation
    And I have checked I Agree
    When I click "Place Order"
    Then I should see "Invalid credit card"
    And a new user should NOT exist
    And they should NOT have an active subscription
    And they should NOT receive a welcome email
    And the label should NOT have 1 fewer credit
