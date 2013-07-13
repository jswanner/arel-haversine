# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arel/haversine/version'

Gem::Specification.new do |spec|
  spec.name          = 'arel-haversine'
  spec.version       = Arel::Haversine::VERSION
  spec.authors       = ['Jacob Swanner']
  spec.email         = ['jacob@jacobswanner.com']
  spec.description   = %q{Provides haversine formula, implemented with Arel; which could be added to ActiveRecord scope, for instance.}
  spec.summary       = %q{Provides haversine formula, implemented with Arel.}
  spec.homepage      = 'https://github.com/jswanner/arel-haversine'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'arel'
  spec.add_dependency 'arel-trigonometry'

  spec.add_development_dependency 'activerecord', '>= 3'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'mysql2'
  spec.add_development_dependency 'pg'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.11'
end
