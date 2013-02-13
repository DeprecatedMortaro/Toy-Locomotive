$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "toy-locomotive/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "toy-locomotive"
  s.version     = ToyLocomotive::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ToyLocomotive."
  s.description = "TODO: Description of ToyLocomotive."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "toy-attributes"
  s.add_dependency "toy-verbs"
  s.add_dependency "toy-resources"

  s.add_development_dependency "rails"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "sqlite3"
end
