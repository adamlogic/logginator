Feature: Viewing log entries

Scenario: Initial page
  Given I am on the initial page
  Then  I should see 50 entries in the summary list

@javascript
Scenario: Initial page
  Given I am on the initial page
  Then  I should see 50 entries in the summary list

Scenario: Viewing a specific entry
  Given I am on the initial page
  When  I click an entry in the summary list
  Then  I should see details for the selected entry
  And   the selected entry should be highlighted in the summary list

@javascript
Scenario: Viewing a specific entry
  Given I am on the initial page
  When  I click an entry in the summary list
  Then  I should see details for the selected entry
  And   the selected entry should be highlighted in the summary list

Scenario: Pagination
  Given I am on the initial page
  When  I click the "older" page link
  Then  I should see entries 51-100
  When  I click the "newer" page link
  Then  I should see entries 1-50

@javascript
Scenario: Pagination
  Given I am on the initial page
  When  I click the "older" page link
  Then  I should see entries 51-100
  When  I click the "newer" page link
  Then  I should see entries 1-50

Scenario: Viewing a specific entry while not on the first pgae
  Given I am on page 2
  When  I click an entry in the summary list
  Then  I should see details for the selected entry
  And   I should see entries 51-100

@javascript
Scenario: Viewing a specific entry while not on the first pgae
  Given I am on page 2
  When  I click an entry in the summary list
  Then  I should see details for the selected entry
  And   I should see entries 51-100
