$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "stellar_lookout/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "stellar_lookout"
  s.version     = StellarLookout::VERSION
  s.authors     = ["Ramon Tayag"]
  s.email       = ["ramon.tayag@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of StellarLookout."
  s.description = "TODO: Description of StellarLookout."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.2"

  s.add_development_dependency "sqlite3"
end
