# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mayl/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Josep M. Bach"]
  gem.email         = ["josep.m.bach@gmail.com"]
  gem.description   = %q{A console to create, edit and maintain YAML files in any kind of Ruby projects}
  gem.summary       = %q{A console to create, edit and maintain YAML files in any kind of Ruby projects}
  gem.homepage      = "http://blog.txustice.me/mayl"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "mayl"
  gem.require_paths = ["lib"]
  gem.version       = Mayl::VERSION

  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'yard-tomdoc'
  gem.add_development_dependency 'redcarpet'

  gem.add_development_dependency 'reek'

  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'mocha'
end
