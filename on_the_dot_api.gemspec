$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "on_the_dot_api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "on_the_dot_api"
  s.version     = OnTheDotApi::VERSION
  s.authors     = ["Bloom and Wild"]
  s.summary     = %q{ruby wrapper for OnTheDot API}
  s.description = %q{ruby wrapper for OnTheDot API}
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency 'rest-client', '~> 2.0.1'

  s.add_development_dependency 'dotenv-rails', '2.0.2'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rspec', '~> 3.7'
  s.add_development_dependency 'webmock', '~> 3.3'
  s.add_development_dependency 'vcr', '~> 4.0'
end
