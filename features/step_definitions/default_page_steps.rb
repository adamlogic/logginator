Given /^there are (\d+) log entries$/ do |arg1|
end

Given /^I am on the initial page$/ do
  visit '/'
end

Then /^I should see (\d+) log summaries$/ do |log_count|
  save_and_open_page
  page.should have_css('.summary', :count => 20)
end

Then /^I should see the detailed entry for the oldest log$/ do
end

