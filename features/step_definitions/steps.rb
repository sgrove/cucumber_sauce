Given /^I am on the Google Homepage$/ do
  @browser.open "/"
end

When /^I enter a "([^\"]*)"$/ do |term|
  @browser.type "q", term
  @browser.click "btnG"
end

Then /^the search results should include "([^\"]*)"$/ do |result|
  source = @browser.get_html_source
  raise Exception unless source.include?(result)
end
