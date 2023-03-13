# frozen_string_literal: true

require 'selenium/webdriver'

Capybara.register_driver :selenium_chrome_in_container do |app|
  Capybara::Selenium::Driver.new app,
                                 browser: :remote,
                                 url: 'http://selenium_chrome:4444/wd/hub',
                                 options: Selenium::WebDriver::Chrome::Options.new
end

Capybara.register_driver :headless_selenium_chrome_in_container do |app|
  Capybara::Selenium::Driver.new app,
                                 browser: :remote,
                                 url: 'http://selenium_chrome:4444/wd/hub',
                                 options: Selenium::WebDriver::Chrome::Options.new(
                                   args: %w[headless disable-gpu]
                                 )
end
