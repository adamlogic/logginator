Feature: Default Page

Scenario: Log summaries
  Given I am on the initial page
  Then  I should see 25 log summaries

Scenario: Log detail
  Given I am on the initial page
  Then  I should see the detailed entry for the oldest log
