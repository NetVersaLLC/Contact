Feature: Callcenter Worker
  In order to allow callcenter workers to track sales
  As a callcenter worker
  I want to be able to login and see sales

  Scenario: Login
    Given I enter login credentils
    When I sign in
    Then I should see the callcenter dashboard

  Scenario: Dashboard
    Given I am logged in as a callcenter worker
    When I view the dashboard
    Then I should see my sales for the week

  Scenario: Fill out form
    Given I am logged in as a callcenter worker
    When I click on customer name on the dashboard
    Then I should see the business edit form

  Scenario: Leaderboard
    Given I am logged in as a callcenter worker
    When I view the dashboard
    Then I should see a list of the top 5 callcenter workers sales
