host = ENV['host'] || "http://google.com"

ondemand = YAML.load_file("ondemand.yml")

Before do |scenario|
  outline = scenario.scenario_outline
  job_name = "#{outline.name.capitalize}: #{scenario.name}"

  @browser = Selenium::Client::Driver.new(
                                          :host => "saucelabs.com",
                                          :port => 4444,
                                          :browser => 
                                          {
                                            "username" => ondemand["username"],
                                            "access-key" => ondemand["api_key"],
                                            "os" => ENV['SELENIUM_BROWSER_OS'],
                                            "browser" => ENV['SELENIUM_BROWSER_NAME'],
                                            "browser-version" => ENV['SELENIUM_BROWSER_VERSION'],
                                            "job-name" => job_name
                                          }.to_json,
                                          :url => host,
                                          :timeout_in_second => 90)

  @browser.start_new_browser_session
end

After do |scenario|
  @browser.close_current_browser_session
end
