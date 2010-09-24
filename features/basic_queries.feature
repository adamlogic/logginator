Feature: Basic queries

Scenario: Filter by controller
  Given I am on the initial page
  When  I filter results for the "users" controller
  Then  all entries in the summary list should be for the "users" controller
  And   the selected entry should be for the "users" controller

Scenario: Filter by controller and action
  Given I am on the initial page
  When  I filter results for the "welcome" controller and "pricing" action
  Then  all entries in the summary list should be for the "welcome#pricing" action
  And   the selected entry should be for the "welcome#pricing" action

Scenario: Filter by request time
  Given I am on the initial page
  When  I filter for results from "2010-09-23 02:20" to "2010-09-23 12:00"
  Then  all entries in the summary list should be between those times
  And   the selected entry should be between those times
