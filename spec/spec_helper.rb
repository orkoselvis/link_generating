require './myapp'
require 'capybara/dsl'
require 'capybara/rspec'
require 'rspec'
require 'timecop'
require 'capybara-screenshot/rspec'

ENV['RACK_ENV'] = 'test'

Capybara.app = Myapp

RSpec.configure do |config|
  config.include Capybara::DSL
  config.order = "random" 
end

Capybara.configure do |config|
  config.run_server = false
  config.app_host = 'https://www.sameplsite.com' # change url
end