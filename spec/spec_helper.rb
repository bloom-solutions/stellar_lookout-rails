# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "pry"
require "shoulda-matchers"
require "factory_girl_rails"
require 'rspec/rails'
require "storext-matchers"

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[StellarLookout::Engine.root.join("spec/support/**/*.rb")].each do |f|
  require f
end

FIXTURES_DIR = Pathname.new(File.dirname(__FILE__)).join("fixtures")

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
