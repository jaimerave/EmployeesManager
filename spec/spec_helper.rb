require 'simplecov'
SimpleCov.start 'rails'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Load Capybara integration:
require 'capybara/rspec'
require 'capybara/rails'

require 'webmock/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def login_admin
  visit root_path
  page.should have_content("Email")
  page.should have_content("Password")
  fill_in "admin_user_email", with: "admin@example.com"
  fill_in "admin_user_password", with: "password"
  click_on "Login"
end

def stub_twitter_calls
  stub_request(:get, "https://api.twitter.com/1/users/show.json?screen_name=JaimeRave").
    with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Twitter Ruby Gem 2.1.1'}).
    to_return(:status => 200, :body => fixture("user_jaimerave.json"), :headers => {})
  stub_request(:get, "https://api.twitter.com/1/users/show.json?screen_name=jaimerave").
    with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Twitter Ruby Gem 2.1.1'}).
    to_return(:status => 200, :body => fixture("user_jaimerave.json"), :headers => {})
  stub_request(:get, "https://api.twitter.com/1/users/show.json?screen_name=jaimerave12345").
    with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Twitter Ruby Gem 2.1.1'}).
    to_return(:status => 404, :body => fixture("user_jaimerave12345.json"), :headers => {})
end