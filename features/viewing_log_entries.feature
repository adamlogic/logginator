Feature: Viewing log entries

Scenario: Initial page
  Given I am on the initial page
  Then  I should see 25 entries in the summary list
  And   I should see details for the oldest entry

Scenario: Viewing a specific entry
  Given I am on the initial page
  When  I click an entry in the summary list
  Then  I should see details for the selected entry
  And   the selected entry should be highlighted in the summary list

Scenario: Pagination
  Given I am on the initial page
  When  I click the "next" page link
  Then  I should see entries 26-50
  When  I click the "previous" page link
  Then  I should see entries 1-25

Scenario: Viewing a specific entry while not on the first pgae
  Given I am on page 2
  When  I click an entry in the summary list
  Then  I should see details for the selected entry
  And   I should see entries 26-50
