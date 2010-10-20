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
  @from = Time.parse(from)
  @to   = Time.parse(to)

  fill_in 'From', :with => from
  fill_in 'To',   :with => to
  click   'Update Results'
end



Then /^all entries in the summary list should be for the "([^"]*)" controller$/ do |controller|
  page.all('#summaries tr').each { |row| row.text.should be_include(controller) }
end

Then /^all entries in the summary list should be for the "([^"]*)" action$/ do |action|
  action_regexp = Regexp.new(action.split(/\b/).join('.*'), Regexp::MULTILINE)
  page.all('#summaries tr').each { |row| row.text.should match(action_regexp) }
end

Then /^all entries in the summary list should be between those times$/ do
  page.all('#summaries tr').each do |row|
    time = Time.parse(row.find(:xpath, Capybara::XPath.from_css('td.time').to_s).text)
    (@from..@to).should be_include(time)
  end
end
