require 'rubygems'
require 'cucumber/rake/task'
require 'selenium/rake/tasks'
require 'parallel'

# Change these to specify which browsers on which 
# platforms you want to cover
@browsers = [{:os => "Windows 2003", :name => "iehta", :version => "6."},
             {:os => "Windows 2003", :name => "iehta", :version => "7."},
             {:os => "Windows 2003", :name => "iehta", :version => "8."},
             {:os => "Windows 2003", :name => "firefox", :version => "3."},
             {:os => "Windows 2003", :name => "safari", :version => "4."},
             {:os => "Windows 2003", :name => "googlechrome", :version => ""}]


desc "Invoke behaviours on all browsers on specified platform"
task :test do
  year, month, day = Date.today.strftime("%Y,%m,%d").split(",")
  dir = "reports/#{year}/#{month}"
  FileUtils::mkdir_p(dir)
  
  Parallel.map(@browsers, :in_processes => @browsers.count) do |browser|
    begin
      ENV['SELENIUM_BROWSER_OS'] = browser[:os]
      ENV['SELENIUM_BROWSER_NAME'] = browser[:name]
      ENV['SELENIUM_BROWSER_VERSION'] = browser[:version]
      ENV['SELENIUM_REPORT_FILENAME'] = "#{dir}/#{day}-#{browser[:os]}_#{browser[:name]}_#{browser[:version]}.html".gsub(/\s/, "_").gsub("..", ".")
      
      year, month, day = Date.today.strftime("%Y,%m,%d").split(",")
      dir = "reports/#{year}/#{month}"
      
      Rake::Task[ :run_browser_tests ].execute({ :browser_name => browser[:name],
                                                 :browser_version => browser[:version],
                                                 :browser_od => browser[:os] })
    rescue RuntimeError
      puts "Error while running task"
    end
  end    
end

Cucumber::Rake::Task.new(:'run_browser_tests') do |t|
  t.cucumber_opts = "--format pretty --format html features"
end

task :default => [:test]
