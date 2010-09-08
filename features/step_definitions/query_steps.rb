require 'date'

When /^I filter results for the "([^"]*)" controller$/ do |controller|
  fill_in 'Controller', :with => controller
  click   'Update Results'
end

When /^I filter results for the "([^"]*)" controller and "([^"]*)" action$/ do |controller, action|
  fill_in 'Controller', :with => controller
  fill_in 'Action',     :with => action
  click   'Update Results'
end

When /^I filter for results from "([^"]*)" to "([^"]*)"$/ do |from, to|
  fill_in 'From', :with => from
  fill_in 'To',   :with => to
  click   'Update Results'
end



Then /^all entries in the summary list should be for the "([^"]*)" controller$/ do |controller|
  page.all('#summaries tr').each { |row| row.should have_content(controller) }
end

Then /^all entries in the summary list should be for the "([^"]*)" action$/ do |action|
  page.all('#summaries tr').each { |row| row.should have_content(action) }
end

Then /^all entries in the summary list should be from "([^"]*)" to "([^"]*)"$/ do |from, to|
  from = Time.parse(from)
  to   = Time.parse(to)

  page.all('#summaries tr').each do |row| 
    time = Time.parse(row.find('td.time').text)
    (from..to).should be_include(time)
  end
end

Then /^the selected entry should be for the "([^"]*)" controller$/ do |controller|
  page.should have_css('#detail .action', :text => /#{controller}/)
end

Then /^the selected entry should be for the "([^"]*)" action$/ do |action|
  page.should have_css('#detail .action', :text => /#{action}/)
end

Then /^the selected entry should be from "([^"]*)" to "([^"]*)"$/ do |from, to|
  from = Time.parse(from)
  to   = Time.parse(to)
  time = Time.parse(page.find('#detail .time').text)

  (from..to).should be_include(time)
end

