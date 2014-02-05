
Feature: Sign in 
  In order to let users access the system 
  As a user 
  I want to sign in

Scenario: Sign In 
  Given I am a user 
  When I sign in 
  Then I should be signed in 

Scenario: Account not registered
  Given I am not a user 
  When I sign in 
  Then I should see a link to sign up 

Scenario: Forgot my password 
  Given I am a user 
  And I forgot my password 
  When I sign in 
  Then I should see a link to reset it 

