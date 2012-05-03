# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "toy-locomotive/version"

Gem::Specification.new do |s|

  s.name        = "toy-locomotive"
  s.version     = ToyLocomotive::VERSION
  s.authors     = ["Christian Mortaro"]
  s.email       = ["mortaro@towsta.com"]
  s.homepage    = ""
  s.summary     = %q{a Toy Locomotive to run over Rails}
  s.description = %q{a Different aproach to Rails applications}

  s.rubyforge_project = "toy-locomotive"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rails"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "shoulda"

end
