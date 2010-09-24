Given /^I am on the initial page$/ do
  visit '/'
end

Given /^I am on page (\d+)$/ do |page|
  @page = page.to_i
  visit "/page/#{@page}"
end



When /^I click an entry in the summary list$/ do
  @position = 3
  @selected_entry = LogEntry.page(@page || 1)[@position]
  request_time    = summary_time_format(@selected_entry['request_time'])

  click request_time
end

When /^I click the "([^"]*)" page link$/ do |link|
  within '#summaries' do
    click_link link
  end
end



Then /^I should see (\d+) entries in the summary list$/ do |log_count|
  page.should have_css('#summaries tr', :count => log_count.to_i)
end

Then /^I should see details for the newest entry$/ do
  newest_entry      = LogEntry.collection.find_one({}, :sort => [:$natural, :desc])
  newest_entry_time = detail_time_format(newest_entry['request_time'])

  page.should have_css('#detail .time', :text => newest_entry_time)
end

Then /^I should see details for the selected entry$/ do
  request_time = detail_time_format(@selected_entry['request_time'])

  page.should have_css('#detail .time', :text => request_time)
end

Then /^the selected entry should be highlighted in the summary list$/ do
  page.should have_css("#summaries tr.selected:nth-child(#{@position + 1})")
end

Then /^I should see entries 1-25$/ do
  page.should have_css("#summaries tr:first-child", :text => /09\/23 19:28:09/)
  page.should have_css("#summaries tr:last-child",  :text => /09\/23 18:52:11/)
end

Then /^I should see entries 26-50$/ do
  page.should have_css("#summaries tr:first-child", :text => /09\/23 18:52:09/)
  page.should have_css("#summaries tr:last-child",  :text => /09\/22 20:11:21/)
end
