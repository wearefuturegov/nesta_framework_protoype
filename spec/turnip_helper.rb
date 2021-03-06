require 'turnip/capybara'
require 'selenium/webdriver'
require 'rails_helper'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  if ENV['CIRCLECI'] || ENV['HEADLESS']
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w(headless disable-gpu) }
    )
  else
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome
  end

  Capybara::Selenium::Driver.new app,
    browser: :chrome,
    desired_capabilities: capabilities
end

Capybara.javascript_driver = :headless_chrome
Capybara.raise_server_errors = false

Dir.glob("spec/features/steps/**/*steps.rb") { |f| load f, true }

def scroll_to(element)
  script = <<-JS
  arguments[0].scrollIntoView(true);
  JS
  Capybara.current_session.driver.browser.execute_script(script, element.native)
  return element
end
