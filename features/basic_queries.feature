Feature: Basic queries

Scenario: Filter by controller
  Given I am on the initial page
  When  I filter results for the "sessions" controller
  Then  all entries in the summary list should be for the "sessions" controller
  And   the selected entry should be for the "sessions" controller

Scenario: Filter by controller and action
  Given I am on the initial page
  When  I filter results for the "features" controller and "show" action
  Then  all entries in the summary list should be for the "features#show" action
  And   the selected entry should be for the "features#show" action

Scenario: Filter by request time
  Given I am on the initial page
  When  I filter for results from "2010-08-26 13:57" to "2010-08-26 13:58"
  Then  all entries in the summary list should be from "2010-08-26 13:57" to "2010-08-26 13:58"
  And   the selected entry should be from "2010-08-26 13:57" to "2010-08-26 13:58"
