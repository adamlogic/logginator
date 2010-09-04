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

Then /^I should see details for the oldest entry$/ do
  oldest_entry      = LogEntry.collection.find_one({}, :sort => :request_time)
  oldest_entry_time = detail_time_format(oldest_entry['request_time'])

  page.should have_css('#detail .time', :text => oldest_entry_time)
end

Then /^I should see details for the selected entry$/ do
  request_time = detail_time_format(@selected_entry['request_time'])

  page.should have_css('#detail .time', :text => request_time)
end

Then /^the selected entry should be highlighted in the summary list$/ do
  page.should have_css("#summaries tr.selected:nth-child(#{@position + 1})")
end

Then /^I should see entries (\d+)\-(\d+)$/ do |range_begin, range_end|
  first_entry = LogEntry.collection.find_one({}, :skip => range_begin.to_i - 1)
  last_entry  = LogEntry.collection.find_one({}, :skip => range_end.to_i - 1)
  first_time  = summary_time_format(first_entry['request_time'])
  last_time   = summary_time_format(last_entry['request_time'])

  page.should have_css("#summaries tr:first-child", :text => /#{first_time}/)
  page.should have_css("#summaries tr:last-child",  :text => /#{last_time}/)
end
