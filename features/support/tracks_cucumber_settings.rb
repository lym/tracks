# commented out because aruba 0.5 conflics
# require 'aruba/cucumber'

require "capybara/rails"
require "capybara/cucumber"
require "capybara/session"
# BUG in this version of cucumber/capybara:
# require 'cucumber/rails/capybara_javascript_emulation'
# # Lets you click links with onclick javascript handlers without using
# @culerity or @javascript

Capybara.default_wait_time = 5
Capybara.javascript_driver = ENV["JS_DRIVER"] ? ENV["JS_DRIVER"].to_sym : :selenium
Capybara.ignore_hidden_elements = false # make find(css) find hidden elements

if Capybara.javascript_driver == :selenium
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome
  capabilities["elementScrollBehavior"] = 1

  Capybara.register_driver :selenium_english do |app|
    Capybara::Selenium::Driver.new(
      app, browser: :chrome, desired_capabilities: capabilities
    )
  end
  Capybara.javascript_driver = :selenium_english
else
  Capybara.register_driver(:headless_chrome) do |app|
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w[headless disable-gpu] }
    )

    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      desired_capabilities: capabilities
    )
  end
  Capybara.javascript_driver = :headless_chrome
end
