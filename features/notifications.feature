Feature: Notifications
  In order to let business owners know about important events.
  As a user.
  I want to see notifications for the business.

Scenario: No notifications.
  Given I am a user 
  When I view the notifications panel.
  Then I should see "You have no pending notifications."

Scenario: Pending notifications
  Given I am a user.
  When I view the notifications panel.
  Then I should see pending notifications.

Scenario: Contains action item.
  Given I am a user 
  And I am viewing pending notifications.
  And there is a pending notification with an action link.
  When I click the action link button.
  Then I should go to the action page.

