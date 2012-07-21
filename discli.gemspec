# -*- encoding: utf-8 -*-
require File.expand_path('../lib/discli/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Chris Hunt"]
  gem.email         = ["c@chrishunt.co"]
  gem.description   = %q{CLI for discogs.com}
  gem.summary       = %q{CLI for discogs.com}
  gem.homepage      = "https://github.com/huntca/discli"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "discli"
  gem.require_paths = ["lib"]
  gem.version       = Discli::VERSION

  gem.add_development_dependency 'rspec'
end
