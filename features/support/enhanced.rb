# Setup all the config infor
ondemand = YAML.load_file("ondemand.yml")
config = {
  :os =>       ENV['SELENIUM_BROWSER_OS'],
  :browser =>  ENV['SELENIUM_BROWSER_NAME'],
  :version =>  ENV['SELENIUM_BROWSER_VERSION'],
  :host =>     ENV['SELENIUM_HOST'] || "http://google.com",
  :username => ondemand["username"],
  :api_key =>  ondemand["api_key"]
}

# Double-check to make sure we have all the config we need to run a proper job
errors = []
config.each_pair { |key, value| errors << "#{key} is nil" if value.nil? }

# Give helpful errors and suggestions if not
unless errors.empty?
  errors.each { |e| puts e }
  puts "... Are you running this from the rake task? That's the recommended methods - it'll run your tests much, much faster. Check it out with:"
  puts "\trake test"
  puts "If not, be sure to set the environment variables."
  puts "\tExample: SELENIUM_BROWSER_OS=\"Windows 2003\" SELENIUM_BROWSER_NAME=\"firefox\" SELENIUM_BROWSER_VERSION=\"3.\" SELENIUM_HOST=\"http://google.com\" cucumber"
  exit 1
end

Before do |scenario|
  outline = scenario.scenario_outline
  job_name = "#{outline.name.capitalize}: #{scenario.name}"

  @browser = Selenium::Client::Driver.new(
                                          :host => "saucelabs.com",
                                          :port => 4444,
                                          :browser => 
                                          {
                                            "username" => config[:username],
                                            "access-key" => config[:api_key],
                                            "os" => config[:os],
                                            "browser" => config[:browser],
                                            "browser-version" => config[:browser_version],
                                            "job-name" => job_name
                                          }.to_json,
                                          :url => config[:host],
                                          :timeout_in_second => 90)

  @browser.start_new_browser_session
end

After do |scenario|
  @browser.close_current_browser_session
end
