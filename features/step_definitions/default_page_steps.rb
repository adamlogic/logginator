Given /^I am on the initial page$/ do
  visit '/'
end

Then /^I should see (\d+) log summaries$/ do |log_count|
  page.should have_css('#summaries tr', :count => 25)
end

Then /^I should see the detailed entry for the oldest log$/ do
  oldest_entry = LogEntry.collection.find_one({}, :sort => :request_time)
  time         = oldest_entry['request_time'].strftime('%b %e, %Y %H:%M:%S')

  page.should have_css('#detail .time', :text => time)
end

