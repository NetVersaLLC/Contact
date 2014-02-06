@focus
Feature: Sign up
	In order to use the provided service
	As a Reseller
	I want to sign up for an user account

Background:
   Given I have label with me


@javascript 
Scenario: Sign up with valid data
	When I sign up with "email@example.com"
   	Then I should be signed in 
