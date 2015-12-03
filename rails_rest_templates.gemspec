$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_rest_templates/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_rest_templates"
  s.version     = RailsRestTemplates::VERSION
  s.authors     = ["Ricardo Baumann"]
  s.email       = ["ricardo.luis.baumann@gmail.com"]
  s.homepage    = "http://github.com/ricardobaumann"
  s.summary     = "Templates for rest api-only applications"
  s.description = "See REDANE"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5"

  s.add_development_dependency "sqlite3"
end
