$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "stellar_lookout/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "stellar_lookout-rails"
  s.version     = StellarLookout::VERSION
  s.authors     = ["Ramon Tayag"]
  s.email       = ["ramon.tayag@gmail.com"]
  s.homepage    = "https://github.com/imacchiato/stellar_lookout-rails"
  s.summary     = "Watch Stellar payments for multiple addresses in a reliable manner"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.2"
  s.add_dependency "typhoeus", "~> 1.0"
  s.add_dependency "gem_config"
  s.add_dependency "storext", "~> 2.0"
  s.add_dependency "light-service"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "storext-matchers"
end
